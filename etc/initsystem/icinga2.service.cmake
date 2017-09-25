[Unit]
Description=Icinga host/service/network monitoring system
After=syslog.target network-online.target postgresql.service mariadb.service carbon-cache.service carbon-relay.service

[Service]
Type=forking
EnvironmentFile=@ICINGA2_SYSCONFIGFILE@
ExecStartPre=@CMAKE_INSTALL_PREFIX@/lib/icinga2/prepare-dirs @ICINGA2_SYSCONFIGFILE@
ExecStart=@CMAKE_INSTALL_FULL_SBINDIR@/icinga2 daemon -d -e ${ICINGA2_ERROR_LOG}
PIDFile=@ICINGA2_RUNDIR@/icinga2/icinga2.pid
ExecReload=@CMAKE_INSTALL_PREFIX@/lib/icinga2/safe-reload @ICINGA2_SYSCONFIGFILE@
TimeoutStartSec=30m

# Introduced in Systemd 226
# Can be a low default, depending on OS defaults (e.g. 512 on OpenSuSE)
# Icinga 2 requires more tasks (checks, notifications, etc.)
TasksMax=infinity
# Ensure we have enough NPROC, openSUSE sets a limit to ~3K
LimitNPROC=62883

[Install]
WantedBy=multi-user.target
