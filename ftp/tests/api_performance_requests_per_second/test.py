# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-28 10:06:27
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-28 12:07:13
from locust import HttpUser, task, between, events
import os


@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--endpoint", type=str, env_var="ENDPOINT")


class NetworkApplicationUser(HttpUser):
    host = os.getenv("HOST")
    wait_time = between(1, 3)

    @task
    def my_task(self):        
        #print(f"endpoint={self.environment.parsed_options.endpoint}")
        #print(f"my_ui_invisible_argument={self.environment.parsed_options.my_ui_invisible_argument}")
        self.client.get(self.environment.parsed_options.endpoint)
