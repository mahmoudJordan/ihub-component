# Define a function to install internal dependencies
initialize() {
    echo "initialize .. copy base component scripts"

    cp -f ../../base-component/scripts/image-deploy.sh ./scripts
    cp -f ../../base-component/scripts/setup-debugging-session.sh ./scripts
    cp -f ../../base-component/scripts/dns.sh ./scripts

    chmod +x ./scripts/image-deploy.sh
    chmod +x ./scripts/setup-debugging-session.sh
    chmod +x ./scripts/dns.sh

    echo "Finished initializing"
}


initialize