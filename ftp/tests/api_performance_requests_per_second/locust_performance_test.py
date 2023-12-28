# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-28 10:06:27
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-28 14:02:17
from locust import HttpUser, task, between, events
import os


@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--endpoint", type=str, env_var="ENDPOINT")
    parser.add_argument("--http-method", type=str, env_var="HTTP_METHOD")


class NetworkApplicationUser(HttpUser):
    host = os.getenv("HOST")
    wait_time = between(1, 3)

    @task
    def performance_task(self):
        endpoint = self.environment.parsed_options.endpoint
        http_method = self.environment.parsed_options.http_method

        if endpoint is None or http_method is None:
            raise ValueError("Missing endpoint or http_method")

        http_method = http_method.upper()
        if http_method not in ["GET", "POST"]:
            raise ValueError(f"Unsupported HTTP method: {http_method}")

        if http_method == "GET":
            self.client.get(endpoint)

        if http_method == "POST":
            self.client.post(endpoint)
