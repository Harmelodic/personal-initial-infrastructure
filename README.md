# personal-infrastructure

Infrastructure code for personal projects

Inside the `src` directory is where the central infrastructure is defined for personal projects. For example:

- Enabling of Cloud APIs
- Kubernetes Cluster & Node pool
- Central Database for re-use (since I'm too cheap to do proper microservice DB isolation)

This is run in a CI/CD pipeline, using the Storage bucket and Service Account created in
the [Initial Infrastructure](https://github.com/Harmelodic/initial-infrastructure) section.
