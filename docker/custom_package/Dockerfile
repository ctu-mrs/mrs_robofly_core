ARG WORKSPACE_PATH
ARG BASE_IMAGE=ctumrs/mrs_uav_system:latest

#############################################################################

# FIRST STAGE: BUILD THE WORKSPACE
FROM $BASE_IMAGE AS stage_build

ARG WORKSPACE_PATH

COPY ./cache/${WORKSPACE_PATH}/ /${WORKSPACE_PATH}/

# create catkin workspace
RUN [ ! -e /${WORKSPACE_PATH}/.catkin_tools ] && cd /${WORKSPACE_PATH} && catkin init && catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && catkin profile set reldeb && catkin config --extend /opt/ros/noetic || echo "[Docker]: catkin workspace already exists"

# copy the sources from the local subfolder
COPY src/ /${WORKSPACE_PATH}/src/

RUN cd /${WORKSPACE_PATH} && catkin build -s

#############################################################################

# SECOND STAGE: COPY THE WORKSPACE TO A BLANK APLINE IMAGE
FROM alpine AS stage_cache_workspace

ARG WORKSPACE_PATH

COPY --from=stage_build /${WORKSPACE_PATH} /${WORKSPACE_PATH}

#############################################################################

# THIRD STAGE: copy the workspace to a final blank ROS-equipped base image
FROM $BASE_IMAGE AS stage_finalization

ARG WORKSPACE_PATH

COPY --from=stage_cache_workspace /${WORKSPACE_PATH} /${WORKSPACE_PATH}

CMD ["bash"]
