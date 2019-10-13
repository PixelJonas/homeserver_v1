                                                                                         
                                                                                         
NAME="$1"                                                                            
SERVICE_NAME="$2"                                                                    
if [ -n "/etc/systemd/system/docker_${SERVICE_NAME}.service" ]; then                 
    service_content="                                                                
[Unit]                                                                                   
Description=${NAME}                                                                      
Requires=docker.service                                                                  
After=docker.service                                                                     
                                                                                         
[Service]                                                                                
Restart=always                                                                           
ExecStart=/usr/bin/docker start -a ${SERVICE_NAME}                                       
ExecStop=/usr/bin/docker stop -t 2 ${SERVICE_NAME}                                       
                                                                                         
[Install]                                                                                
WantedBy=multi-user.target                                                               
"                                                                                        
    echo "${service_content}" >> "/etc/systemd/system/docker_${SERVICE_NAME}.service"
    systemctl enable "docker_${SERVICE_NAME}.service"                                
else                                                                                 
    echo "Service /etc/systemd/system/docker_${SERVICE_NAME}.service already exists" 
fi                                                                                   
                                                                                         
                                                                                         