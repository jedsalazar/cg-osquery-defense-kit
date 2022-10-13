out/odk-detection.sql:
	mkdir -p out
	osqtool pack detection/ > out/odk-detection.conf

out/odk-policy.sql:
	mkdir -p out
	osqtool pack policy/ > out/odk-policy.conf

out/odk-incident_response.sql:
	mkdir -p out
	osqtool pack incident_response/ > out/odk-incident_response.conf

packs: out/odk-detection.sql out/odk-policy.sql out/odk-incident_response.sql

out/odk-packs.zip: packs
	cd out && zip odk-packs.zip *.conf

all: out/odk-packs.zip