# GitHub Advanced Security BootCamp Exercises

For the exercises, you need your provided classroom repository. In this classroom repository, you can play around with GitHub Advanced Security settings.

Keep in mind that the steps in these exercises are to learn the product and not to rush through them. Feel free to look around and deviate from the provided path.

Sometimes you need to look up information. You can use your search engine or AI assistance.

Some handy links that you might need:

- [GitHub Docs](https://docs.github.com/en)
- [GitHub Support](https://support.github.com/)
- [Copilot in GitHub Support (only if you have a GitHub Copilot license)](https://support.github.com/success/copilot)

**Exercises**

- [Secret Protection](#exercise-1---secret-protection)
- [Dependency Management](#exercise-2---dependency-management)
- [Code Security](#exercise-3---code-security)
- [Advanced Code Security](#exercise-4---advanced-code-security)
- [GHAS Administration](#exercise-5---ghas-administration)
- [Dashboarding and Security Campaigns](#exercise-6---dashboarding-and-security-campaigns)

## Exercise 1 - Secret Protection

You will get your hands dirty when it comes to Secret Protection.

### Enabling Secret Protection

- Accept the invite to your provided classroom GitHub Organization. This organization is sponsored by GitHub.
- You see one repository called `juice-shop`. This is a private repository.
- Go to the settings of the repository and check the Advanced Security settings.
- Notice that Advanced Security is disabled. This is because it is a private repository. Enable Advanced Security
- Enable Secret Protection in your classroom repository
  - Including 'Scan for generic secrets'
  - Including 'Non-provider patterns'
  - Don't enable push protection

### Examine alerts

- Examine the alerts in the Secret Scanning Generic tab. You will notice four 'HTTP bearer authentication header' alerts.
- Dismiss one of the alerts as a false positive / used in tests

### Exclude a folder

- Exclude the test folder by creating a `secret_scanning.yml` file in the `.github` folder of your repository.
- Notice that the alerts from the tests folder are closed in the Secret Scanning Generic tab.

### Add a secret

- Generate a GitHub PAT (Personal Access Token) with the following scopes:
  - repo
  - read:org
- Copy the token to your clipboard and delete the token directly to prevent token leaks,
- Create a file in the root of the git repository. Name it `something.json` and add the following content:

```json
{
  "value": "<your generated token>"
}
```

- Examine the alert under the Secret Scanning Default tab

### Push protection

- Enable push protection for the repository
- Try to commit and push a secret. For example, the GitHub PAT of the previous section. Expose the secret by pushing anyway (follow the links in the block message)
- Check how the validity works in the alert
- Try to commit and push another secret. Remove the secret from your git history (follow the links in the block message)
- Don't forget to revoke your GitHub PAT!
- View your emails and see the notifications
- View the closed alert in the Secret Scanning Default tab

### Detected by 'Scan for generic passwords'

- After about five minutes, you will see a couple of generated alerts that are Detected by Copilot Secret Scanning/Scan for generic passwords. The repository needs to be analyzed first and this takes a while.
- Examine those secrets.

## Exercise 2 - Dependency Management

You will get your hands dirty when it comes to Dependency Management and Dependabot.

### Dependency Graph

- Enable the Dependency Graph in the settings of your provided classroom repository. Also include 'Automatic dependency submission'.
- Browse the Dependency Graph in the Insights tab.

### Dependabot Alerts

- Enable Dependabot Alerts in the settings of your provided classroom repository.
- Check the Dependabot Alerts in the Security tab.
- Open the 'marsdb' alert and notice that it is a Command Injection vulnerability. Notice that there is no fix available.
- Check the vulnerability details like CWE, CVE, and Severity. Sort on EPSS and analyze the alert that has the highest EPSS score.
- Create a 'Dependabot rule' to dismiss the alert until a patch is available. Use ecosystem:npm as the target for easiness.
  - Note: If you can't create a rule, this is most likely because Advanced Security is not enabled on the repository. Enable it and try again.

### Dependabot security updates

- Enable Dependabot Security Updates in the settings of your provided classroom repository.
- Notice the Pull Requests that are created by Dependabot. This can take a couple of minutes. Check your action workflows runs.
- Notice in the Dependabot Alerts tab you will see information about the Pull Request.
- Some alerts do not contain a security update. Analyze why this is.
- Enable 'Grouped Security Updates' in the settings of your provided classroom repository. Check again your action workflows runs.
- You will notice that the created pull requests are dismissed and a new one is created, grouping the pull requests.

### Dependabot version updates

- Enable Dependabot version updates. Enable 'Grouped Version Updates' in the ‘dependabot.yml' file and make it so that it checks daily for npm only. Add a label: 'just testing'.
- Check again the action workflows runs. You will notice that the pull request is created and grouped updates. (note this will take several minutes)

### Dependabot Review pipeline

- Go to the actions tab and add a new workflow through the marketplace. Search for 'Dependency review'.
- Create a branch ruleset (go to the repository settings, rules and create a new branch ruleset).
  - Include the default branch.
  - Add 'Required status checks to pass' and select the 'Dependency review' check.
- Create a new branch, add "lodash": "4.17.21" to the 'package.json' file and commit the change.
- Create a Pull Request. See that the Dependency review pipeline runs. Check the feedback in the PR.
- If you want and have time, you can also add an old version of lodash that will block the PR from merging.

## Exercise 3 - Code Security 

You will get your hands dirty when it comes to Code Security.

### Enable Basic Code Security

- Enable CodeQL analysis in the settings of your provided classroom repository. Choose the basic option and leave the defaults.
  - Also turn on 'Copilot Autofix'
- Check the Actions tab and check the CodeQL workflow/logs
- Go to the Security tab to check the Code Scanning Alerts. Analyze some critical and high severities (press the 'show more' to get more context)
  - Check the CWE
  - Create an issue from the alert

### GitHub Copilot Autofix

- Open a Code Scanning alert
- Click on the 'Autofix' button
- Check the solution and commit the fix towards a new branch
- Notice the PR that is created and that CodeQL checks are running

### Branch policies

- Create a branch ruleset (go to the repository settings, rules and create a new branch ruleset)
  - Include the default branch
  - Add 'Required code scanning results'. Notice that CodeQL is already there

### Switch to Advanced CodeQL scanning

- Go to the Code scanning settings and switch to Advanced CodeQL scanning. Here you can customize the workflow
- Remove the python analysis and save the workflow. Notice that it uses a matrix

## Exercise 4 - Advanced Code Security

### Switch to security-and-quality

- Adjust your CodeQL workflow so that it uses the `security-and-quality` query suite
- Analyze the alerts, you will notice that there are more alerts now

### Create a configuration file

- Create a `codeql-config.yml`file
- Use security-extended as the query suite
- Only include the `frontend` and the `tests` folder

### Getting started with the codeql CLI

- Follow the instructions on the [Getting started with the codeql CLI](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/setting-up-the-codeql-cli) page

Instead of downloading the CLI manually, you can also use the Visual Studio Code extension for CodeQL. See [the extension in the marketplace](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-codeql)

### Preparing your code for CodeQL analysis

- Follow the instructions on the [](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/preparing-your-code-for-codeql-analysis) page

### Analyzing your code with CodeQL queries

- Follow the instructions on the [](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/analyzing-your-code-with-codeql-queries) page

## Exercise 5 - GHAS Administration

### Create a Security Configuration

- Go to the organization settings and check the Advanced Security settings
- Set some global settings like:
  - Grouped security updates
  - Dependabot on Actions runners
- Create a security configuration and enable all features
  - Notice that some features need to be set on repo level (like version updates and advanced codeql setup)
- Apply the configuration to your juice-shop repository
- Check the juice-shop repository settings and see the configuration applied. The settings in your configuration cannot be changed on repo level

## Exercise 6 - Dashboarding and Security Campaigns

### Security

- Go to the Security tab. Check all the tabs
- Can you find your bypassed secret push?

### Insights

- Go to the Insights tab. Check the dependencies and their licenses

### Security Campaigns

- Create a security campaign (can be done from the security tab in the organization)
- Create a new campaign to fix all the critical severity alerts
