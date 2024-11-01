FROM ctumrs/mrs_uav_system:latest

LABEL mrs.uav.system.version=1.5.0

RUN curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash

RUN apt-get -y update && apt-get -y upgrade --allow-downgrades --with-new-pkgs

CMD ["/ros_entrypoint.sh"]
