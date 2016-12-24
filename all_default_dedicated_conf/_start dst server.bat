@echo off
cd /d %~dp0
cd "steamapps\common\Don't Starve Together Dedicated Server\bin"
start "Master" dontstarve_dedicated_server_nullrenderer -console -cluster dedicated -shard Master
start "Caves" dontstarve_dedicated_server_nullrenderer -console -cluster dedicated -shard Caves