FROM ctumrs/mrs_uav_system:1.5.0

LABEL mrs.uav.system.version=1.5.0-custom

RUN curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash

RUN apt-get -y update && apt-get -y upgrade --allow-downgrades

CMD ["/ros_entrypoint.sh"]
