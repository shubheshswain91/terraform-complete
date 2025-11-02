### Question 1:
A development team is tasked with deploying a new containerized application. The lead engineer contrasts two approaches:

- Approach 1: Write a detailed shell script with a series of docker commands (docker network create, docker run --network..., docker volume create...) that must be executed in a specific sequence to build the environment.

- Approach 2: Define the desired final state of the application environment—including services, networks, and volumes—in a single YAML file and use a tool to make the live environment match this file.

Which statement best describes the primary advantage of Approach 2 over Approach 1?



A(1): Approach 2 is declarative, focusing on the "what" (the desired end state), while Approach 1 is imperative, focusing on the "how" (the specific steps to get there). This makes the infrastructure definition easier to understand and maintain.

Correct

This is the correct answer. Approach 2 (like using Docker Compose or Kubernetes manifests) is declarative. It defines the target state, and the tool figures out how to achieve it. Approach 1 (a shell script) is imperative; it lists the exact sequence of commands to run. The declarative approach is generally more robust, readable, and less prone to errors from incorrect sequencing.

### Question 2:
A financial services company has a strict security policy stating that all new cloud database instances must be encrypted at rest and cannot be publicly accessible. How does using Infrastructure as Code most effectively help enforce this policy across all development teams?


By creating a reusable, version-controlled IaC module for database provisioning that has the required security settings (encryption enabled, no public IP) pre-configured as non-negotiable defaults.

Correct

This is the correct answer. Using a shared, secured-by-default module is a primary strength of IaC. It allows a central security or platform team to codify best practices, which development teams can then use, ensuring compliance without needing to be experts on every security setting.

### Question 3:
A company manages its cloud networking infrastructure using IaC. The repository's code defines a security group that allows inbound traffic only on port 443 (HTTPS). One evening, an urgent issue with a monitoring tool requires a developer to temporarily allow traffic on port 8080. The developer signs into the cloud provider's web console and manually adds a new rule to the security group to allow this traffic. The next morning, the monitoring works, but an automated IaC run overwrites the security group, removing the rule for port 8080 and breaking the tool again.

What is the correct term for the situation that occurred before the automated run?


Configuration Drift

Correct

This is the correct answer. Configuration drift occurs when the actual state of the infrastructure in the live environment (with the manually added 8080 rule) differs from the state defined in the IaC source code (which only specifies port 443). IaC tools are designed to detect and correct this drift.

### Question 4:
A company needs to spin up multiple, identical staging environments for its QA team to test new application features in isolation. Each environment consists of a virtual machine, a database, and specific networking rules. The process of creating these environments is complex and must be repeatable with 100% accuracy.

Why is an IaC approach vastly superior to a manual process documented in a wiki page for this use case?


IaC allows the entire environment to be defined in code, which can be versioned and executed by an automation pipeline to create identical environments on demand, eliminating human error.

Correct

This is the correct answer. IaC excels at reproducibility. By codifying the environment's definition, the company guarantees that every environment created from that code will be identical, which is crucial for reliable testing. A wiki page is prone to being outdated and requires manual execution, which can lead to errors and inconsistencies.

### Question 5:
A junior engineer is following a tutorial to set up a simple web server. The tutorial provides a list of CLI commands to run in order:



aws ec2 create-vpc ... (Create a VPC)
aws ec2 create-subnet --vpc-id <VPC_ID> ... (Create a subnet inside the VPC)
aws ec2 create-security-group --vpc-id <VPC_ID> ... (Create a security group)
aws ec2 run-instances --subnet-id <SUBNET_ID> --security-group-ids <SG_ID> ... (Launch the server)


The engineer copies and pastes the commands but accidentally runs the run-instances command before the create-subnet command. What is the most likely outcome?


The run-instances command will fail because it references a subnet ID that does not yet exist, demonstrating the error-prone nature of imperative, sequential commands.

Correct

This is the correct answer. The process is imperative, meaning the order of operations is critical. run-instances depends on the output (the ID) of create-subnet. If the subnet hasn't been created, its ID won't be valid, and the API call will fail. This highlights a key weakness of manual, imperative processes that IaC helps solve.


### Question 6:
A data analytics startup needs to run a large batch processing job every night. The job requires a powerful cluster of 50 virtual machines but only needs to run for about two hours. The company wants to minimize costs. How does IaC directly support this business goal?


By enabling the automated creation of the entire cluster just before the job starts and the automated destruction of all resources immediately after the job finishes, ensuring the company only pays for the hours the resources are actually used.

Correct

This is the correct answer. This is a classic use case for IaC's cost management benefits. The ability to programmatically create and destroy entire environments with single commands (terraform apply and terraform destroy, for example) makes it easy to manage ephemeral infrastructure and avoid paying for idle resources.


### Question 7:
An organization's infrastructure is managed via IaC, and the codebase is stored in a Git repository. A new feature requires a change to a database configuration. The developer creates a new branch, modifies the IaC file, and opens a pull request.

What is the primary benefit of this workflow?


It allows for peer review of infrastructure changes, providing a clear audit trail of who proposed, approved, and merged the change before it is ever applied to the live environment.

Correct

This is the correct answer. Integrating IaC with a version control system like Git enables powerful workflows like peer review via pull requests. This ensures changes are vetted for correctness, security, and adherence to standards. It also creates an immutable history of every change made to the infrastructure.