import os
import fileinput
import shutil
import glob
import subprocess

def find_current_project_name():
    projects = glob.glob('*.xcodeproj')
    if projects:
        return projects[0].split('.')[0]
    else:
        print("No Xcode project found.")
        return None

def rename_xcode_project(old_name, new_name):
    if not old_name:
        return

    # Rename the .xcodeproj file
    os.rename(f'{old_name}.xcodeproj', f'{new_name}.xcodeproj')

    # Update references in the project file
    with fileinput.FileInput(f'{new_name}.xcodeproj/project.pbxproj', inplace=True) as file:
        for line in file:
            print(line.replace(old_name, new_name), end='')

    # Optionally, rename the main project folder
    if os.path.isdir(old_name):
        os.rename(old_name, new_name)

def remove_git_directory_and_reinit():
    if os.path.isdir('.git'):
        shutil.rmtree('.git')
        print("Reinitializing a new Git repository.")

        # Reinitialize the Git repository
        subprocess.run(['git', 'init'])
    else:
        print("No .git directory found, initializing a new Git repository.")
        subprocess.run(['git', 'init'])
    

current_project_name = find_current_project_name()
if current_project_name:
    new_project_name = input("Enter the new project name: ")

    rename_xcode_project(current_project_name, new_project_name)
    print(f"Project has been renamed from \"{current_project_name}\" to \"{new_project_name}\".")
    remove_git_directory_and_reinit()
