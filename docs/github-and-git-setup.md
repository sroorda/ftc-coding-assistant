# Set Up GitHub and Git for Level 2

Level 2 uses a shared team repository. You will have your own cumulative branch,
so your work remains separate from other students while still allowing code
review.

## 1. Prepare your GitHub account

1. Create or sign in to the GitHub account approved for team use.
2. Verify the email address associated with the account.
3. Accept the invitation to the team's repository or GitHub organization.
4. Open `<HARDWARE_LAB_REPOSITORY_URL>` in a browser and confirm that you can see
   it.

Use [GitHub's account documentation](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github)
if you need help creating the account. Do not put a password, access token, Wi-Fi
credential, or recovery code in a repository, lesson response, or AI prompt.

## 2. Install Git

Follow [GitHub's Set up Git documentation](https://docs.github.com/en/get-started/git-basics/set-up-git)
for your operating system. Then open a terminal and run:

```text
git --version
```

Continue when Git prints a version instead of an error.

## 3. Identify your commits

Use the name you want teammates to see in repository history and the email address
approved for your GitHub account:

```text
git config --global user.name "Your Name"
git config --global user.email "your-approved-email@example.com"
```

Verify the saved values without displaying unrelated Git settings:

```text
git config --global user.name
git config --global user.email
```

Students who do not want a personal email shown in commits can use a GitHub-provided
`noreply` address after configuring it in their GitHub email settings.

## 4. Authenticate through the approved method

The mentor will choose HTTPS or SSH for the hardware-lab repository. Follow that
choice rather than changing the repository URL yourself.

- For HTTPS, use the browser or credential-manager sign-in offered by Git.
- For SSH, use the SSH key and GitHub account setup approved by the mentor.

Do not paste a password or token into a command shown by another student. Stop and
ask a mentor if authentication requests a credential you do not recognize.

## Check your setup

You are ready to clone when:

- `git --version` succeeds;
- your Git name and approved email are configured;
- you can view the hardware-lab repository on GitHub; and
- you understand that `origin` will mean the team's repository, not FIRST's
  official repository.

Continue to [Your Level 2 Git Workflow](level-2-git-workflow.md).
