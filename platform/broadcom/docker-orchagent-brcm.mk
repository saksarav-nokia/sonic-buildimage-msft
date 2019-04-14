# docker image for orchagent

DOCKER_ORCHAGENT_BRCM_STEM = docker-orchagent-brcm
DOCKER_ORCHAGENT_BRCM = $(DOCKER_ORCHAGENT_BRCM_STEM).gz
DOCKER_ORCHAGENT_BRCM_DBG = $(DOCKER_ORCHAGENT_BRCM_STEM)$(DBG_IMAGE_MARK).gz

$(DOCKER_ORCHAGENT_BRCM)_PATH = $(DOCKERS_PATH)/docker-orchagent
$(DOCKER_ORCHAGENT_BRCM)_DEPENDS += $(SWSS) $(REDIS_TOOLS)
$(DOCKER_ORCHAGENT_BRCM)_DBG_DEPENDS = $(SWSS_DBG) \
                                    $(LIBSWSSCOMMON_DBG) \
                                    $(LIBSAIREDIS_DBG)
ifeq ($(INSTALL_DEBUG_TOOLS), y)
$(DOCKER_ORCHAGENT_BRCM)_DEPENDS += $($(DOCKER_ORCHAGENT_BRCM)_DBG_DEPENDS)
endif
$(DOCKER_ORCHAGENT_BRCM)_DBG_DEPENDS += $($(DOCKER_CONFIG_ENGINE_STRETCH)_DBG_DEPENDS)

$(DOCKER_ORCHAGENT_BRCM)_LOAD_DOCKERS += $(DOCKER_CONFIG_ENGINE_STRETCH)
$(DOCKER_ORCHAGENT_BRCM)_DBG_IMAGE_PACKAGES = $($(DOCKER_CONFIG_ENGINE_STRETCH)_DBG_IMAGE_PACKAGES)

SONIC_DOCKER_IMAGES += $(DOCKER_ORCHAGENT_BRCM)
SONIC_STRETCH_DOCKERS += $(DOCKER_ORCHAGENT_BRCM)
SONIC_INSTALL_DOCKER_IMAGES += $(DOCKER_ORCHAGENT_BRCM)

SONIC_DOCKER_DBG_IMAGES += $(DOCKER_ORCHAGENT_BRCM_DBG)
SONIC_STRETCH_DBG_DOCKERS += $(DOCKER_ORCHAGENT_BRCM_DBG)
SONIC_INSTALL_DOCKER_DBG_IMAGES += $(DOCKER_ORCHAGENT_BRCM_DBG)

$(DOCKER_ORCHAGENT_BRCM)_CONTAINER_NAME = swss
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += --net=host --privileged -t
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += -v /etc/network/interfaces:/etc/network/interfaces:ro
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += -v /etc/network/interfaces.d/:/etc/network/interfaces.d/:ro
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += -v /host/machine.conf:/host/machine.conf:ro
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += -v /etc/sonic:/etc/sonic:ro
$(DOCKER_ORCHAGENT_BRCM)_RUN_OPT += -v /var/log/swss:/var/log/swss:rw

$(DOCKER_ORCHAGENT_BRCM)_BASE_IMAGE_FILES += swssloglevel:/usr/bin/swssloglevel
$(DOCKER_ORCHAGENT_BRCM)_FILES += $(ARP_UPDATE_SCRIPT)
