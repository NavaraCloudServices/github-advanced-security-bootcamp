# GitHub Advanced Security BootCamp Exercises

For the exercises you need your provided class room repository. In this classroom repository you can play around with GitHub Advanced Security settings.

Keep in mind that the steps in these exercises are to getting to learn the product and not to rush trough them. Feel free to look around and deviate from the provided path.

Sometimes you need to lookup for information. You can use your search engine or AI assistance.

Some handy links that you might need:

- [GitHub Docs](https://docs.github.com/en)
- [Copilot in GitHub Support](https://support.github.com/success/copilot)

## Exercise 1 - Secret Scanning

You will get your hands dirty when it comes to Secret Scanning.

### Enabling Secret Scanning

- Go to the settings of your provided classroom repository.
- Notice that Advanced Security is disabled. This is because it is a private repository.
- Enable Secret Scanning in your classroom repository
  - Including 'Scan for generic secrets'
  - Including 'Non-provider patterns’
  - Don't enable push protection

### Examine alerts

- Examine the alerts in the Secret Scanning Experimental tab. You will notice four 'HTTP bearer authentication header' alerts.
- Dismiss one of the alerts as a false positive / used in tests

### Exclude a folder

- Exclude the test folder by creating a “secret_scanning.yml" file in the .github folder of your repository.
- Notice that the alerts are closed from the Secret Scanning Experimental tab that are from the tests folder.

### Add a secret

- Create a file in the root of the git repository. Name it `something.json` and add the following content:

```json
{
  "value": "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"
}
```

- Examine the alert under the Secret Scanning Default tab

### Push protection

- Enable push protection for the repository
- Try to commit and push a secret. For example a GitHub PAT (and change one letter). Expose the secret by pushing anyway (follow the links in the block message)
- Check how the validity works in the alert
- Try to commit and push another secret. Remove the secret from your git history (follow the links in the block message)
- Don't forget to revoke your GitHub PAT!
- View your e-mails and see the notifications
- View the closed alert in the Secret Scanning Default tab

### Detected by Copilot Secret Scanning

- After about five minutes you will see a couple of generated alerts that are Detected by Copilot Secret Scanning. The repository needs to be analysed first and this takes a while
- Examine those secrets.

## Exercise 2 - Dependency Management

You will get your hands dirty when it comes to Dependency Management and Dependabot

### Dependency Graph

- Enable the Dependency Graph in the settings of your provided classroom repository. Also include 'Automatic dependency submission'
- Browse the Dependency Graph in the Insights tab.

### Dependabot Alerts

- Enable Dependabot Alerts in the settings of your provided classroom repository
- Check the Dependabot Alerts in the Security tab.
- Open the 'marsdb' alert and notice that it is a Command Injection vulnerability. Notice that there is no fix available.
 - Check the vulnerability details like CWE, CVE and Severity
- Create a 'Dependabot rule' to dismiss the alert until a patch is available. Use ecosystem:npm as target for easyness
  - Note: If you can't create a rule, this is most likely because Advanced Security is not enabled on the repository. Enable it and try again.

### Dependabot security updates

- Enable Dependabot Security Updates in the settings of your provided classroom repository
- Notice that Pull Requests that are created by Dependabot. This can take a couple of minutes. Check your action workflows runs.
- Notice in the Dependabot Alerts tab you will see information about the Pull Request
- Some alerts do not contain a security update. Analyse why this is.
- Enable 'Grouped Version Updates' in the settings of your provided classroom repository. Check again your action workflows runs.
- You will notice that the created pull requests are dismissed and a new one is created, grouping the pull requests

### Dependabot version updates

- Enable Dependabot version updates. Enable 'Grouped Version Updates' in the ‘dependabot.yml' file and make it so that it checks daily for npm only. Add a label: 'just testing'
- Check again the action workflows runs. You will notice that the pull request is created and grouped updates. (note this will take several minutes)

### Dependabot Review pipeline

- Go to the actions tab and add a new workflow through the marketplace. Search for 'Dependency review'
- Create a branch ruleset (go to the repository settings, rules and create a new branch ruleset)
  - Include the default branch
  - Add 'Required status checks to pass' and select the 'Dependency review' check
- Create a new branch, add "lodash": "4.17.21" to the 'package.json' file and commit the change
- Create a Pull Request. See that the Dependency review pipeline runs. Check the feedback in the PR
- If you want and have time, you can also add an old version of lodash that will block the PR from merging

## Exercise 3 - Code Scanning

You will get your hands dirty when it comes to Secret Scanning.

### Enable Basic Code Scanning

- Enable CodeQL analysis in the settings of your provided classroom repository. Choose the basic option and leave the defaults.
  - Also turn on 'Copilot Autofix'
- Check the Actions tab and check the CodeQL workflow/logs
- Go to the Security tab to check the Code Scanning Alerts. Analyse some critical and high severities (press the 'show more' to get more context)
  - Check the CWE

### GitHub Copilot Autofix

- Open a Code Scanning alert
- Click on the 'Autofix' button
- Check the solution and commit the fix towards a new branch
- Notice the PR that is created and that CodeQL checks are running

### Branch policies

- Create a branch ruleset (go to the repository settings, rules and create a new branch ruleset)
  - Include the default branch
  - Add 'Required code scanning results'. Notice that CodeQL is already there

### Advanced CodeQL scanning

- Go to the Code scanning settings and switch to Advanced CodeQL scanning. Here you can customize the workflow
- Remove the python analysis and save the workflow