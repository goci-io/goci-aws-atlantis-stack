# goci-aws-atlantis-stack

**Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)**

![terraform](https://github.com/goci-io/goci-aws-atlantis-stack/workflows/terraform/badge.svg?branch=master&event=push)

[Install Stack on goci.io](https://goci.io/dashboard/providers/atlantis/wizard)

### Contains:
- Atlantis Server via Helm Release
- Server IAM Role with custom Policies
- GitHub Repository, Webhook Config and Branch Protection
- Initial Atlantis Repo Level Config (not available for Bitbucket)
- Importing existing [Route53 DNS Stack](https://github.com/goci-io/goci-aws-route53-stack) to create TLS Certificates and DNS Record

#### Note for Bitbucket Users
The current official release of Bitbucket Terraform Provider is missing a lot of Resources we need to completely setup your Atlantis Environment. It also seems that the Provider is [no longer actively maintained](). We will keep Track of Changes to the Bitbucket Provider but for now you will setup your Repository yourself following [Atlantis Documentation](https://www.runatlantis.io/docs/repo-level-atlantis-yaml.html). It is also required to create the Webhook Integration. You can get any Details you need from the Atlantis Dashboard on goci.io.

_This repository was created via [github-repository](https://github.com/goci-io/github-repository)._
