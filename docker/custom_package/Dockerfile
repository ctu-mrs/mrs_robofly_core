FROM ctumrs/mrs_uav_system:latest

ARG WORKSPACE_PATH="/etc/robofly/catkin_workspace"

# create catkin workspace
RUN mkdir -p ${WORKSPACE_PATH} && cd ${WORKSPACE_PATH} && rm -rf ./* && mkdir src
RUN cd ${WORKSPACE_PATH} && catkin init

# set workspace build profile
RUN cd ${WORKSPACE_PATH} && catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && catkin profile set reldeb && catkin config --extend /opt/ros/noetic 

# copy the sources from the local subfolder
COPY src/ ${WORKSPACE_PATH}/src/

RUN ls ${WORKSPACE_PATH}/src/

RUN \
    cd ${WORKSPACE_PATH} && catkin build
    # --mount=type=cache,target=${WORKSPACE_PATH}/devel \
    # --mount=type=cache,target=${WORKSPACE_PATH}/build \

RUN mkdir -p /etc/robofly/ws && cp -r ${WORKSPACE_PATH}/* /etc/robofly/ws/

CMD ["bash"]
