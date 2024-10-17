FROM ctumrs/mrs_uav_system:latest

RUN curl https://ctu-mrs.github.io/ppa-unstable/add_ppa.sh | bash

RUN apt-get -y update && apt-get -y upgrade --allow-downgrades

CMD ["bash"]
