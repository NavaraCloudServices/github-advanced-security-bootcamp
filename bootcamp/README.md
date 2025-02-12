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
  value: "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"
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