from pathlib import Path
from ScriptCollection.ScriptCollectionCore import ScriptCollectionCore
from ScriptCollection.TFCPS.TFCPS_Tools_General import TFCPS_Tools_General
from ScriptCollection.TFCPS.Docker.TFCPS_CodeUnitSpecific_Docker import TFCPS_CodeUnitSpecific_Docker_Functions,TFCPS_CodeUnitSpecific_Docker_CLI
from ScriptCollection.OCIImages.OCIImageManager import OCIImageManager


def update_dependencies():
    script_file = str(Path(__file__).absolute())
    sc = ScriptCollectionCore()
    tf:TFCPS_CodeUnitSpecific_Docker_Functions=TFCPS_CodeUnitSpecific_Docker_CLI.parse(__file__)
    oci_image_manager:OCIImageManager=OCIImageManager(sc)
    image=oci_image_manager.get_registry_address_for_image_with_default_tag(tf.get_repository_folder(),"Debian")
    tg=TFCPS_Tools_General(sc)
    tg.update_dependency_in_resources_folder(script_file, "Tor", sc.get_latest_apt_package_version_in_debian( image, "tor"))


if __name__ == "__main__":
    update_dependencies()
