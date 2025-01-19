# (C) 2023-2024 RisingOS
# (C) 2025 Raspberry Project

# Project Raspberry versioning

PRODUCT_SOONG_NAMESPACES += \
    vendor/raspberry/version

RASPBERRY_FLAVOR := VanillaIceCream
RASPBERRY_VERSION := 15
RASPBERRY_CODENAME := Candle
RASPBERRY_RELEASE_TYPE := STABLE
RASPBERRY_CODE := $(RASPBERRY_VERSION)

RASPBERRY_BUILD_DATE := $(shell date +%y%m%d%H)

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
MAINTAINER_LIST := $(shell cat vendor/official_devices/OTA/raspberry.maintainers)
DEVICE_LIST := $(shell cat vendor/official_devices/OTA/raspberry.devices)

RASPBERRY_BUILDTYPE := UNOFFICIAL

ifeq ($(WITH_GMS), true)
	ifeq ($(TARGET_CORE_GMS), true)
    	RASPBERRY_PACKAGE_TYPE ?= CORE
	else
    	RASPBERRY_PACKAGE_TYPE ?= GAPPS
	endif
else
    RASPBERRY_PACKAGE_TYPE ?= VANILLA
endif

# Build version
RASPBERRY_BUILD_VERSION := $(RASPBERRY_VERSION)-$(RASPBERRY_RELEASE_TYPE)-$(RASPBERRY_BUILD_DATE)-$(RASPBERRY_PACKAGE_TYPE)-$(RASPBERRY_BUILDTYPE)-$(CURRENT_DEVICE)

# Display version
RASPBERRY_DISPLAY_VERSION := $(RASPBERRY_VERSION)-$(RASPBERRY_RELEASE_TYPE)-$(RASPBERRY_PACKAGE_TYPE)-$(RASPBERRY_BUILDTYPE)-$(CURRENT_DEVICE)

# Project Raspberry properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.raspberry.code=$(RASPBERRY_CODENAME) \
    ro.raspberry.packagetype=$(RASPBERRY_PACKAGE_TYPE) \
    ro.raspberry.releasetype=$(RASPBERRY_BUILDTYPE) \
    ro.raspberry.version?=$(RASPBERRY_VERSION) \
    ro.raspberry.build.version=$(RASPBERRY_BUILD_VERSION) \
    ro.raspberry.display.version?=$(RASPBERRY_DISPLAY_VERSION) \
    ro.raspberry.platform_release_codename=$(RASPBERRY_FLAVOR) \
    ro.raspberry.device=$(CURRENT_DEVICE) \
    ro.raspberry.storage?=$(RASPBERRY_STORAGE) \
    ro.raspberry.ram?=$(RASPBERRY_RAM) \
    ro.raspberry.battery?=$(RASPBERRY_BATTERY) \
    ro.raspberry.display_resolution?=$(RASPBERRY_DISPLAY)
