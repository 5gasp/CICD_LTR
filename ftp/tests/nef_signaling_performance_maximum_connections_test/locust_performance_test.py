# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-28 10:06:27
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-05 08:27:51
from locust import HttpUser, task, between, events
import os


@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--endpoint", type=str, env_var="ENDPOINT")


class NetworkApplicationUser(HttpUser):
    host = os.getenv("HOST")
    wait_time = between(1, 3)

    @task
    def performance_task(self):
        endpoint = self.environment.parsed_options.endpoint

        if endpoint is None:
            raise ValueError("Missing endpoint.")

        self.client.post(
            endpoint,
            json={
                "externalId": "10001@domain.com",
                "ipv4Addr": "10.0.0.1",
                "subscription": "4a21f2e1-67eb-4d0b-9e5c-7b1d20e07b7d",
                "monitoringType": "LOCATION_REPORTING",
                "locationInfo": {
                    "cellId": "AAAAA1001",
                    "enodeBId": "AAAAA1"
                }
            }
        )
