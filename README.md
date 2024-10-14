# opentofu-template
The opentofu-template repo offers a streamlined template for deploying infrastructure with OpenTofu, a Terraform fork. It follows best practices for modularity, environment-specific variables, and security. Ideal for quick cloud infrastructure setup, it also supports CI/CD for automated deployments.

## Features
- **Modular design**: Breaks down infrastructure into reusable components.
- **Environment variables**: Easily configure different environments with variables.
- **Security**: Follows best practices for secure infrastructure setup.
- **CI/CD support**: Automate deployments with GitHub Actions.

## Usage
1. Clone the repo.
2. Run `(terraform || tofu) init` to initialize the working directory.
3. Run `(terraform || tofu) plan` to view the changes Terraform will make.
4. Run `(terraform || tofu) apply` to apply the changes.