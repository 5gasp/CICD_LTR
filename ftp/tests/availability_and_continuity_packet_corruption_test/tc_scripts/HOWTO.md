Create 
sudo nano /etc/systemd/system/throttling.service

    [Unit]
    Description=My Python script
    After=multi-user.target
    
    [Service]
    Type=idle
    ExecStart=/usr/bin/python3 /home/localadmin/tc.py
    
    [Install]
    WantedBy=multi-user.target

Reload to get the new configuration
sudo systemctl daemon-reload

To enable the service
sudo systemctl enable throttling.service

To start the service
sudo systemctl start throttling.service

To see the status of the service
sudo systemctl status throttling.service

To stop the service
sudo systemctl stop throttling.service
