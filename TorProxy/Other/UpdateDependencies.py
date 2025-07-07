from pathlib import Path
from ScriptCollection.ScriptCollectionCore import ScriptCollectionCore
from ScriptCollection.TasksForCommonProjectStructure import TasksForCommonProjectStructure


def update_dependencies():
    script_file = str(Path(__file__).absolute())
    sc = ScriptCollectionCore()
    debian_version = sc.get_docker_debian_version("stable")
    TasksForCommonProjectStructure().update_dependency_in_resources_folder(script_file, "Tor", sc.get_latest_tor_version_of_debian_repository(debian_version))


if __name__ == "__main__":
    update_dependencies()
