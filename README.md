git-workflow-tool
=================

Handy tool for dealing with releasing code to multiple stages. The methodology here is to have and integration branch (usually this is master, but can be changed as desired) in which feature branches are created off the integration branch. The feature branches are all designed to merge back into the integration branch--either periodically or when the feature changes are complete. 

On a regular schedule as the development team dictates the integration branch can be promoted to a release branch. There may be any number of release branches that can be ancestors of integration branch, but each release branch may only be derived from its parent branch. In other words each release branch receives its changes only from the release branch that is one step closer to the integration branch and may only send changes to one release branch that is one step further away from the integration branch.

If one were to picture the layout of the branches with respect to the integration branch, the following would be an accurate picture. 

                     master
                        |
         db_upd        /|
             /--------- |\     test
             |          | -------\
             |          |        |
             |  hotfix /|        |\  staging
             |    /---- |        | -----\ 
             |    |     |        |      |
             |    \---- |        |      |
             |         \|        |      |\    production
             |          |\       |      | --------\
             |\-------- | ------\|      |         |
             |         \|        |\     |         |
             |          |        | ---- |         |
             \--------- |        |     \|         |
                       \|        |      |\        |
                        |        |      | ------- |
            add_col    /|        |      |        \|
                ------- |        |      |         |
               /        |        |      |         |
               |        |        |      |         |

As you can see the features are to the left of the integration branch (master) and the release branches are to the right. The feature branches may be merged with the integration branch any number of times for the purpose of reducing the possibility of causing conflicts, but when merged with the integration branch the change set should be complete and not break a build on the integration branch. 

As can be seen in the diagram, changes progress through the release branches and never skip a release level. Although it is perfectly acceptable for a change set reach a specific release level and not progress any further. A typical example might be when changes cause the testing done at the test branch to fail; it would not be desirable to allow the change set to progress any further. 


Setup
-----

The setup of the workflow and integration branches is accomplished with the set subcommand. To set the integration branch to use the following command would be executed:

    gwt set integration <branch>
    
Setting the workflow (i.e. the release branches that are used) consists of listing each branch that should be used during the release process starting with the branch that is one step off of the integration branch.

    gwt set workflow <branch> <branch> <branch...>
    

Features
--------

The feature branches are all the branches to the left of the integration branch in the diagram above--they are sometimes referred to as left branches. They can be created and destroyed at will using the following commands:

    gwt feature [new|create|add] <branch>
    gwt feature [delete|del|remove|rm] [<branch>]
    
In the case of removing a feature branch, if the feature branch is currently checked out, then the branch name can be omitted and the working directory will be left on the integration branch after executing the remove command. 

Any normal git branch can be converted to a feature branch by simply creating a feature with the same name as the git branch. 

The list of features can be listed at any point with the list subcommand.

    gwt feature [list|ls]
    

Integration
-----------

The integration branch should not have commits applied directly to it. Changes should always occur on a feature branch and the integrated into the integration branch with the following command:

    gwt integrate

The gwt integrate command merges the changes on the current feature branch to the integration branch, thus merging with the integration branch should only occur when commits are complete and will not break a the integration code. This can also be used to find out what the integration branch breaks in the integration branch so that the changes can be modified to fit into the integration branch without breaking it. 

Changes can be pulled from the integration branch to a feature branch with the following command:

    gwt [pull|update]


Promotion
---------

At some point there is a desire to release code to the release branches. This is done with the promote command. 

CLI
---

    gwt feature [create|add|new] NAME
    gwt feature [list|ls]
    gwt feature [delete|del|remove|rm] [NAME]
    
    gwt [--no-push] integrate [NAME]
    gwt [--no-push] promote [NAME]
    
    gwt info
    gwt set workflow BRANCH BRANCH ...
    gwt set integration BRANCH
    