plugins:
  proxy:
    name: "${jenkins_proxy_http}"
    noProxyHost: "${jenkins_no_proxy_list}"
    port: ${jenkins_proxy_http_port}
jenkins:
  systemMessage: "Jenkins configured automatically by Jenkins Configuration as Code Plugin\n\n"
  numExecutors: 5
  scmCheckoutRetryCount: 2
  mode: NORMAL
  securityRealm:
    local:
      allowsSignup: false
      enableCaptcha: false
      users:
      - id: $${ADMIN_USER}
        password: $${ADMIN_PASSWORD}
  authorizationStrategy:
    loggedInUsersCanDoAnything:
      allowAnonymousRead: false
  globalNodeProperties:
  - envVars:
      env:
      - key: "CONFIG_REPO_URL"
        value: "${jenkins_config_repo_url}"
      - key: "JOB_REPO_URL"
        value: "${jenkins_job_repo_url}"
      - key: "AWS_REGION"
        value: "${aws_region}"
      - key: "AWS_OPERATIONS_ACCOUNT_NUMBER"
        value: "${aws_operations_account_number}"
      - key: "AWS_APPLICATION_ACCOUNT_NUMBER"
        value: "${aws_application_account_number}"
      - key: "PRODUCT_DOMAIN_NAME"
        value: "${product_domain_name}"
      - key: "ENVIRONMENT_TYPE"
        value: "${environment_type}"
      - key: "CROSS_ACCOUNT_ROLE_NAME"
        value: "${cross_account_role_name}"
  crumbIssuer:
    standard:
      excludeClientIPFromCrumb: false
security:
  remotingCLI:
    enabled: false
credentials:
  system:
    domainCredentials:
    - credentials:
      - basicSSHUserPrivateKey:
          scope: GLOBAL
          id: "bitbucket-key"
          username: "git"
          passphrase: "" #Doable, but not recommended
          description: "SSH Credentials for git to BitBucket"
          privateKeySource:
            directEntry:
              privateKey: $${GITPRIVATEKEY}
jobs:
  - script: >
      pipelineJob("Generate_IAM_Policies_Operations") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/iam/create/${iam_jobs_path}/Jenkinsfile")
          }
        }
       }
      pipelineJob("Generate_IAM_Policies_Application") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("application/iam/create/${iam_jobs_path}/Jenkinsfile")
          }
        }
       }
      pipelineJob("Kubernetes_Install") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/kubernetes/install/Jenkinsfile")
          }
        }
       }
      pipelineJob("Kubernetes_Destroy") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/kubernetes/destroy/Jenkinsfile")
          }
        }
       }
      pipelineJob("Install_Kubernetes_Application_Account") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("application/kubernetes/install_eks/Jenkinsfile")
          }
        }
       }
      pipelineJob("Generate_JX_Docker_Image") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/images/jenkins-x-image/Jenkinsfile")
          }
        }
       }
      pipelineJob("JX_Install") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.2.1")
              }
            }
            scriptPath("operations/jx/install/Jenkinsfile")
          }
        }
       }
      pipelineJob("JX_Destroy") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.2.1")
              }
            }
            scriptPath("operations/jx/destroy/Jenkinsfile")
          }
        }
       }
      pipelineJob("Grafana_Install") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/grafana/install/Jenkinsfile")
          }
        }
       }
      pipelineJob("Grafana_Destroy") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/grafana/destroy/Jenkinsfile")
          }
        }
       }
      pipelineJob("Prometheus_ops_Install") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/prometheus/install/Jenkinsfile")
          }
        }
       }
      pipelineJob("Prometheus_ops_Destroy") {
        description()
        disabled(false)
        keepDependencies(false)
        definition {
          cpsScm {
            scm {
              git {
                remote {
                  url("${jenkins_job_repo_url}")
                  credentials("bitbucket-key")
                }
                branch("0.3.0")
              }
            }
            scriptPath("operations/prometheus/destroy/Jenkinsfile")
          }
        }
      }
unclassified:
  location:
    adminAddress: you@example.com
    url: http://${jenkins_url}/
