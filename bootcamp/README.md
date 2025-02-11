# GitHub Advanced Security BootCamp Exercises

For the exercises you need your provided class room repository. In this classroom repository you can play around with GitHub Advanced Security settings.

Keep in mind that the steps in these exercises are to getting to learn the product and not to rush trough them. Feel free to look around and deviate from the provided path.

Sometimes you need to lookup for information. You can use your search engine or AI assistance.

Some handy links that you might need:

- [GitHub Docs](https://docs.github.com/en)
- [Copilot in GitHub Support](https://support.github.com/success/copilot)

## Exercise 1 - Secret Scanning

You will get your hands dirty when it comes to Secret Scanning.

- Go to the settings of your provided classroom repository.
- Notice that Advanced Security is disabled. This is because it is a private repository.
- Fully enable Secret Scanning in your classroom repository
  - Including 'Scan for generic secrets'
  - Including 'Non-provider patterns’

Examine the alerts in the Experimental tab. You will see 4
Change the file ‘data\static\users.xml
You will see a banner 'We are running a full history scan of this repository.’ This takes around 5 minutes. In the mean time:
Get some coffee or thee
Try to commit and push a secret. For example a GitHub PAT (and change one letter). Expose the secret by pushing anyway (follow the links in the block message)
Try to commit and push another secret. Remove the secret from your git history (follow the links in the block message)
Examine the alerts in the Experimental tab
Exclude the test folder by creating a “secret_scanning.yml" file
Dismiss the ‘HTTP basic authentication header’ alert as a false positive
