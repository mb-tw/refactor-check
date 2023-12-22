# Refactor check
This check is currently only looking if there are more then one `<div />` tags present in the modified files (i.e. components) on pre-commit. If so the component should be refactored in order to prevent components to become unreadable, too large and providing too much functionality (i.e. a lack of separation of concerns). 

`scripts/pre-commit.sh` can be copied for your own project use. 
Use the `pre-commit` script in `package.json` to make the command `npm run pre-commit` available.
Use husky or [`.git/hooks/pre-commit`](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) to execute the `npm run pre-commit` before each commit.
