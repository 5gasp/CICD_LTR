# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2022-08-02 16:19:02
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2022-08-04 10:26:12

import subprocess
import os

TEST_CAR_PLATE = None


def process_command(command):
    result = subprocess.call(command, shell=True)
    return result


# --------------------------- INSTALL REQUIREMENTS -------------------------- #
def install_requirements():
    curr_dir = os.path.dirname(os.path.realpath(__file__))

    # Install requirements
    requirements_file_path = os.path.join(curr_dir, "aux", "requirements.txt")
    ret_code = process_command(
        f"python3 -m pip install -r {requirements_file_path}"
    )
    if ret_code != 0:
        return "Error: Couldn't install the requirements"
    print("Requirements installed")

    return "Success: Requirements installed"


install_requirements()
# ----------------------- END OF INSTALL REQUIREMENTS ----------------------- #



# ----------------------- GET AVAILABLE TEST CAR PLATE ---------------------- #
import requests
import time
import subprocess
import os

MAX_TRIES = 120

def get_available_car_plate(desired_car_plate, host_ip, port):
    global TEST_CAR_PLATE
    
    # Get available car plate
    print(f"Checking if the plate '{desired_car_plate}' is available...")

    TEST_CAR_PLATE = desired_car_plate
    print(f"Success: Car Plate = {desired_car_plate}")
    return f"Success: Car Plate = {desired_car_plate}"
    #requestURL = f"http://{host_ip}:{port}/all"
#
    #run = 0
    #while run < MAX_TRIES:
    #    # deal with VNF instantiation delays
    #    try:
    #        response = requests.get(
    #            requestURL,
    #            verify=False,
    #            timeout=10,
    #        )
    #        response_text = response.text
    #        response_data = response.json()
#
    #        if response_data is None:
    #            return "Error: The response is empty"
#
    #        if response_data['status'] == "OK":
    #            if desired_car_plate in response_text:
    #                print("The desired car plate is already registered")
    #                desired_car_plate += 'X'
    #                continue
    #            TEST_CAR_PLATE = desired_car_plate
    #            print(f"Success: Car Plate = {desired_car_plate}")
    #            return f"Success: Car Plate = {desired_car_plate}"
#
    #        else:
    #            return "Error: Aggregator's API is not ready"
#
    #    except Exception as e:
    #        print(f"Error: An exception was raised: {str(e)}")
#
    #    run += 1
    #    time.sleep(1)
#
    #return "Error: Couldn't perform any request to the Aggreagator's API"
# --------------------- END GET AVAILABLE TEST CAR PLATE -------------------- #



# ---------------------------- SIMULATE OBU DATA --------------------------- #
import sys, os, time, os.path
import subprocess
import requests, threading
import logging, configparser
from _thread import interrupt_main


from signal import signal, SIGPIPE, SIG_IGN 
signal(SIGPIPE,SIG_IGN) 
 
from coapthon.server.coap import CoAP
from coapthon.resources.resource import Resource
from coapthon.client.helperclient import HelperClient
import os


global vobu_ip 
global obu_plate
global manager_ip

global vehicle
global mutex

global clientCoap
global config

vobu_ip = ''
obu_plate = ''
manager_ip = ''
clientCoap = {}

vehicle = {}
mutex = threading.Lock()

id_counter = 0

here = os.path.dirname(os.path.realpath(__file__))

### Definición de la clase VehicleResource. Se usará como recurso base para el server del protocolo CoAP. 
### Tiene los 4 métodos que vemos dentro, por lo que se puede tanto enviar recursos como solicitarlos.
class VehicleResource(Resource):
    def __init__(self, name="VehicleResource", initial_value=None, coap_server=None):
        super(VehicleResource, self).__init__(name, coap_server, visible=True,
                                            observable=True, allow_children=True)
        self.payload = initial_value

    def render_GET(self, request):
        return self

    def render_PUT(self, request):
        self.payload = request.payload
        return self

    def render_POST(self, request):
        res = VehicleResource()
        res.location_query = request.uri_query
        res.payload = request.payload
        return res

    def render_DELETE(self, request):
        return True

### Definición del servidor CoAP. Tendrá recursos del tipo VehicleResource, accesibles mediante vehicle/KEY
def coap_server(ifaces, port):
    global _FINISH
    class CoAPServer(CoAP):
        def __init__(self, host, port):
            CoAP.__init__(self, (host, port))
            self.add_resource('vehicle/', VehicleResource("vehicle", "{}", self))
            print(self.root.dump())

    server = CoAPServer(ifaces, port)
    try:
        print("CoAP Server: Start listening...")
        server.listen(10)
    except KeyboardInterrupt:
        print("CoAP Server: Server Shutdown")
        server.close()
        print("Exiting...")

### Este método se encarga de solicitar al Manager una vOBU para hacer la asociación vOBU-OBU.
def send_vobu_request():

    global vobu_ip
    global obu_plate
    global manager_ip

    print(obu_plate)
    url = 'http://'+manager_ip+':' + config["surrogates_managerPort"] + '/getVobu?plate='+ obu_plate
    try:
        response = requests.get(url)
    except:
        print("error: Manager non-reachable.")
        return
    try:
        values = response.json()
        print(response)
        print(values)

        for(key,value) in values.items():
            print(key + " " + value)
            if(key.startswith("vobu_ip")):
                vobu_ip = value
                break
            elif(value.startswith("ERROR")):
                print("ERROR")
                return False

    except ValueError:
        print("error " + response.text)
        return False
    
    print("Status code: " + str(response.status_code))
    return True

### Este método se encarga de decirle al Manager que queremos liberar la vOBU que tenemos asociada. 
def liberate_vobu_request(my_id):

    global manager_ip
    url = 'http://'+manager_ip+':' + config["surrogates_managerPort"] + '/getVobu?plate='+ my_id

    try:
        response = requests.delete(url)
    except Exception:
        print("error: Manager non-reacheable")
        return
    
    print("Status code: " + str(response.status_code))
    return ''


### Este método es el que ejecuta el envío CoAP. Es usado por el send_post de abajo. 
def send_coap_message(target, port, path, payload):

    global clientCoap
    
    if not target in clientCoap: 
        clientCoap[target] = HelperClient(server=(target, port))
    
    response = ""

    try:
        response = clientCoap[target].post(path, payload, None, 5)
    except Exception as e:
        print("LA EXCEPCION ----> ", e)
        clientCoap[target].stop()
        del clientCoap[target]

    return response


### Este método realiza el envío de cada linea a la vOBU. También actualiza la información en los recursos vehicle de la propia OBU antes de mandarla. 
def send_post(line):
    global vobu_ip
    global mutex

    temp = line.split("\"")
    if len(temp) < 4:
        return 0
    
    key = temp[1]
    value = temp[3]
    previous_value = vehicle.get(key)

    if(not key.startswith("CAR_PLATE")):
        if(previous_value != None):
            if(previous_value == value):
                return 0
    
    mutex.acquire()
    vehicle[key] = value
    mutex.release()

    try: 
        send_coap_message('127.0.0.1', int(config["listening_port"]), "vehicle/" + key + "/", value)
        send_coap_message(vobu_ip, int(config["surrogates_vOBU_portCOAP"]), "vehicle/" + key + "/", value)
    except Exception as e:
        print(e)

### Este método se lanza en un thread, y se encarga de solicitar una vOBU al Manager y enviar periódicamente los datos, linea a linea, a la vOBU.
def info_sending_task():
    global vobu_ip
    global obu_plate
    global manager_ip
    global _FINISH

    curr_dir = os.path.dirname(os.path.abspath(__file__))
    dummy_data_file = open(os.path.join(curr_dir, "aux", "obu_dummy_data.txt"), "r")
    
    while not send_vobu_request() and not _FINISH:
        print("Requesting vOBU...")
        time.sleep(2)

    print("Sending info to vOBU with IP: " + vobu_ip)
    
    while(not _FINISH):
        try: 
            line = dummy_data_file.readline().strip()
            line = line.replace("<TEST_CAR_PLATE>", obu_plate)
            print(line)
            if len(line) == 0:
                break
            if line.startswith('EOF') or line.startswith('{') or line.startswith('}'):
                continue
            else:
                send_post(line)
                
            
        except (IOError, BrokenPipeError, EOFError) as e:
            pass
        
    print("Bye bye")
    _FINISH = True
        
### CONFIG FUNCTIONALITY

def get_configuration (configuration, config_file_path=""):
    
    configuration["listening_family"] = "ipv4"
    configuration["listening_address"] = "0.0.0.0"
    configuration["listening_port"] = 8060
    configuration["surrogates_managerPort"] = 8070
    configuration["surrogates_vOBU_portCOAP"] = 12342
    configuration["logging_level"] = "debug"
    configuration["logging_filepath"] = "./output.log"
    configuration["logging_format"] = "%(asctime)s; %(levelname)s; %(message)s"
    configuration["logging_append"] = "yes"

    cfg = configparser.RawConfigParser()

    curr_dir = os.path.dirname(os.path.abspath(__file__))
    
    if (config_file_path != ""):
        if (cfg.read([config_file_path])):
            print("Reading configuration from ["+ config_file_path + "]...")
            __read_config(configuration,cfg)
            return True
        else:
            print("Error reading config file ["+config_file_path+"]. Stop.")
            return False
    elif (cfg.read([os.path.join(curr_dir, "aux", "./obu.conf")])):
        print("Reading configuration from default config file in [./obu.conf]...")
        __read_config(configuration,cfg)
        return True
    else:
        # Generate a default config file with default values
        print("Generated new config file with default values [./obu.conf].")
        cfg.add_section("listening")
        cfg.add_section("surrogates")
        cfg.add_section("logging")

        cfg.set("listening", "family", configuration["listening_family"])
        cfg.set("listening", "address", configuration["listening_address"])
        cfg.set("listening", "port", str(configuration["listening_port"]))
        cfg.set("surrogates", "managerPort", str(configuration["surrogates_managerPort"]))
        cfg.set("surrogates", "vOBU_portCOAP", str(configuration["surrogates_vOBU_portCOAP"]))
        cfg.set("logging", "level", configuration["logging_level"])
        cfg.set("logging", "filepath", configuration["logging_filepath"])
        cfg.set("logging", "format", configuration["logging_format"])
        cfg.set("logging", "append", configuration["logging_append"])

        f = open("./obu.conf", "w")
        cfg.write(f)
        f.close()
        return False


def __read_config(configuration, cfg):
    if (cfg.has_option("listening", "family")):
        configuration["listening_family"] = cfg.get("listening", "family")
    else:
        print("Unespecified listen family. Using default: "+configuration["listening_family"])

    if (cfg.has_option("listening", "address")):
        configuration["listening_address"] = cfg.get("listening", "address")
    else:
        print("Unespecified listen address. Using default: "+configuration["listening_address"])

    if (cfg.has_option("listening", "port")):
        configuration["listening_port"] = cfg.get("listening", "port")
    else:
        print("Unespecified listening port. Using default: "+str(configuration["listening_port"]))
        
    if (cfg.has_option("surrogates", "managerPort")):
        configuration["surrogates_managerPort"] = cfg.get("surrogates", "managerPort")
    else:
        print("Unespecified Surrogates Manager Port. Using default: "+str(configuration["surrogates_managerPort"]))
        
    if (cfg.has_option("surrogates", "vOBU_portCOAP")):
        configuration["surrogates_vOBU_portCOAP"] = cfg.get("surrogates", "vOBU_portCOAP")
    else:
        print("Unespecified vOBU COAP Port. Using default: "+str(configuration["surrogates_vOBU_portCOAP"]))

    if (cfg.has_option("logging", "level")):
        configuration["logging_level"] = cfg.get("logging", "level")
    else:
        print("Unespecified logging level. Using default: "+configuration["logging_level"])

    if (cfg.has_option("logging", "filepath")):
        configuration["logging_filepath"] = cfg.get("logging", "filepath")
    else:
        print("Unespecified logging filepath. Using default: "+configuration["logging_filepath"])

    if (cfg.has_option("logging", "format")):
        configuration["logging_format"] = cfg.get("logging", "format")
    else:
        print("Unespecified logging format. Using default: "+configuration["logging_format"])

    if (cfg.has_option("logging", "append")):
        configuration["logging_append"] = cfg.get("logging", "append")
    else:
        print("Unespecified logging append flag. Using default: "+configuration["logging_append"])


def change_logging_config():
    global config

    print("Setting logging level to [" + config["logging_level"].upper() + "], logpath ["+ config["logging_filepath"]+ "], append ["+config["logging_append"].lower()+"]...")

    numeric_level = getattr(logging, config["logging_level"].upper(), None)
    if not isinstance(numeric_level, int):
        raise ValueError('Invalid log level: %s' % numeric_level)
    if (config["logging_filepath"]==""):
        logging.basicConfig(level=numeric_level, format=config["logging_format"])
    else:
        logging.basicConfig(level=numeric_level, format=config["logging_format"], filename=config["logging_filepath"])
    if (config["logging_append"].lower() == "no"):
        logging.basicConfig(filemode='w')

### Método principal. Obtiene la IP del manager y la matrícula. Lanza un thread para envío periódico a la vOBU (usando CoAP) y el propio servidor CoAP para atender peticiones de recursos concretos.
def simulate_obu_data(my_manager_ip):
    global config
    global manager_ip
    global obu_plate
    global TEST_CAR_PLATE
    global _FINISH
    
    _FINISH = False
    manager_ip = my_manager_ip
    obu_plate = TEST_CAR_PLATE
    
    
    config = {}
    get_configuration(config)
    change_logging_config()

    try:
        threadCoAP = threading.Thread(target=info_sending_task)
        threadCoAP.daemon = True
        threadCoAP.start()
        threadCoAPServer = threading.Thread(target=coap_server, args=(config["listening_address"],int(config["listening_port"]), ))
        threadCoAPServer.daemon = True
        threadCoAPServer.start()
        threadCoAP.join()
        print("Finished")
        print("Releasing vOBU...")
        liberate_vobu_request(obu_plate)
        print("Closing OBU Server...")
        return f"Success: Dummy Data Generated for Car Plate {obu_plate}"
    except EOFError:
        print("EOF mark in input data.")
        return f"Success: Could Not Generate Dummy Data for Car Plate {obu_plate}"
# --------------------------- END SIMULATE OBU DATA -------------------------- #



# ----------------------------- CONSUME OBU DATA ---------------------------- #
def get_obu_attributes( host_ip, port):
    global TEST_CAR_PLATE

    time.sleep(30)
    print(f"Checking if the OBU with the plate '{TEST_CAR_PLATE}' has data...")

    requestURL = f"http://{host_ip}:{port}/availableAttributes?vehicle={TEST_CAR_PLATE}"

    run = 0
    while run < MAX_TRIES:
        # deal with VNF iinstantiation delays
        try:
            response = requests.get(
                requestURL,
                verify=False,
                timeout=10,
            )
            response_data = response.json()
            print(response_data)

            if response_data is None:
                return "Error: The response is empty"

            if response_data['status'] == "OK":
                attributes = response_data["value"]
                if len(attributes) > 0:
                    return "Success: OBU has several attributes"
                else:
                    if run == MAX_TRIES - 1:
                        return "Error: OBU has no attributes"

            else:
                return "Error: Aggregator's API is not ready"

        except Exception as e:
            print(f"Error: An exception was raised: {str(e)}")

        run += 1
        time.sleep(1)

    return "Error: Couldn't perform any request to the Aggreagator's API"
# --------------------------- END CONSUME OBU DATA -------------------------- #



# -------------------------- UNINSTALL REQUIREMENTS ------------------------- #
def uninstall_requirements():
    curr_dir = os.path.dirname(os.path.realpath(__file__))

    # Install requirements
    requirements_file_path = os.path.join(curr_dir, "aux", "requirements.txt")
    ret_code = process_command(
        f"python3 -m pip uninstall -r {requirements_file_path} -y"
    )
    if ret_code != 0:
        return "Error: Couldn't uninstall the requirements"
    print("Requirements uninstalled")

    return "Success: Requirements uninstalled"

# ---------------------- END OF UNINSTALL REQUIREMENTS ---------------------- #