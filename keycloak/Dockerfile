FROM quay.io/keycloak/keycloak:24.0.5

COPY ./realms/test_realm.json /opt/keycloak/data/import/test_realm.json

ENV KEYCLOAK_ADMIN=admin \
    KEYCLOAK_ADMIN_PASSWORD=password \
    PROXY_ADDRESS_FORWARDING=true \
    KC_DB=postgres \
    KC_DB_URL=jdbc:postgresql://postgres:5432/keycloak \
    KC_DB_USERNAME=keycloak \
    KC_DB_PASSWORD=keycloakpassword \
    KC_HOSTNAME_PATH=/ \
    KC_HOSTNAME=localhost \
    KC_HOSTNAME_PORT=8095 