import os
from ScriptCollection.GeneralUtilities import GeneralUtilities
from ScriptCollection.TFCPS.Docker.TFCPS_CodeUnitSpecific_Docker import TFCPS_CodeUnitSpecific_Docker_Functions,TFCPS_CodeUnitSpecific_Docker_CLI


def common_tasks():
    tf:TFCPS_CodeUnitSpecific_Docker_Functions=TFCPS_CodeUnitSpecific_Docker_CLI.parse(__file__)
    tf.do_common_tasks(tf.get_version_of_project())#codeunit-version should alsways be the same as project-version
    tor_version=tf.tfcps_Tools_General.get_dependency_version_in_resources_folder(os.path.join(tf.get_codeunit_folder(),"Other","Resources"),"Tor")
    GeneralUtilities.replace_regex_each_line_of_file(os.path.join(tf.get_codeunit_folder(),"ReadMe.md"),"The currently used Tor\\-version is .*\\.", f"The currently used Tor-version is {tor_version}.")


if __name__ == "__main__":
    common_tasks()
