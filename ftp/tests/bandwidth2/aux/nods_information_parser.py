# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   09-06-2022 09:13:25
# @Email:  rdireito@av.it.pt
# @Last Modified by:   Rafael Direito
# @Last Modified time: 10-06-2022 10:32:49
# @Description: 

import base64
import json

class NetworkInformationParser:
    
    def __init__ (self, network_info_b64):
        self.network_info_b64 = network_info_b64
        self.network_info_dict = self.b64_to_dict()

    
    def b64_to_dict(self):
        base64_bytes = self.network_info_b64.encode('utf-8')
        message_bytes = base64.b64decode(base64_bytes)
        message = message_bytes.decode('utf-8')
        parsed_info = json.loads(message)
        return parsed_info
       
    def get_field_info(self, element_chain):
        
        try:
            chain_dict = { 
                e.strip().split("=")[0]: e.strip().split("=")[1]
                for e
                in element_chain.split(",")
            }
            
            info = self.network_info_dict[f"ns-id-{chain_dict['ns_index']}"] \
                [f"vnf-id-{chain_dict['vnf_index']}"] \
                [f"vdu-id-{chain_dict['vdu_index']}"] \
                [f"interface-id-{chain_dict['interface_index']}"] \
                [chain_dict['field']]
            return info
        except Exception as e:
            print(e)
            
        
