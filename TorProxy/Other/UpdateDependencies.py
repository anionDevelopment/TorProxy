from pathlib import Path
import os
from functools import cmp_to_key
from ScriptCollection.ScriptCollectionCore import ScriptCollectionCore
from ScriptCollection.GeneralUtilities import GeneralUtilities
from ScriptCollection.TFCPS.TFCPS_Tools_General import TFCPS_Tools_General
from ScriptCollection.TFCPS.Docker.TFCPS_CodeUnitSpecific_Docker import TFCPS_CodeUnitSpecific_Docker_Functions,TFCPS_CodeUnitSpecific_Docker_CLI


def update_dependencies():
    script_file = str(Path(__file__).absolute())
    sc = ScriptCollectionCore()
    tf:TFCPS_CodeUnitSpecific_Docker_Functions=TFCPS_CodeUnitSpecific_Docker_CLI.parse(__file__)
    image_definitions_csv_file=GeneralUtilities.normalize_path(f"{tf.get_repository_folder()}/.ScriptCollection/OCIImages/ImageDefinition.csv")
    debian_tag=[f for f in GeneralUtilities.read_nonempty_lines_from_file(image_definitions_csv_file) if f.startswith("Debian;")][0].split(";")[2]
    TFCPS_Tools_General(sc).update_dependency_in_resources_folder(script_file, "Tor", sc.get_latest_apt_package_version_in_debian( f"debian:{debian_tag}", "tor"))


if __name__ == "__main__":
    update_dependencies()
