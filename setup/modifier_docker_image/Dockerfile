FROM ctumrs/mrs_uav_system:1.5.0

RUN curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash

RUN apt-get -y update && apt-get -y upgrade --allow-downgrades

CMD ["/ros_entrypoint.sh"]
