# E-Commerce_3-tier-AWS_EKS_with_Helm
Deploy an E-Commerce Three Tier application on AWS EKS with Helm &amp; Terraform

Introduction:
In the dynamic landscape of software development, architects and developers constantly seek robust design patterns that ensure scalability, maintainability, and efficient resource utilization. One such time-tested approach is the 3-tier architecture, a well-structured model that divides an application into three interconnected layers. This architectural style has been a cornerstone for building scalable and resilient applications for decades.

Understanding the Basics:

The 3-tier architecture is composed of three primary layers, each with distinct responsibilities:

Presentation Layer:
Also known as the user interface layer, this tier is responsible for interacting with end-users.

It encompasses the user interface components, such as web pages, mobile apps, or any other interface through which users interact with the application.

The goal is to provide a seamless and intuitive user experience while keeping the presentation logic separate from the business logic.

2. Application (or Business Logic) Layer:

Positioned between the presentation and data layers, the application layer contains the business logic that processes and manages user requests.

It acts as the brain of the application, handling tasks such as data validation, business rules implementation, and decision-making.

Separating the business logic from the presentation layer promotes code reusability, maintainability, and adaptability to changes.

3. Data Layer:

The data layer is responsible for managing and storing the application’s data.

It includes databases, data warehouses, or any other data storage solutions.

This layer ensures data integrity, security, and efficient data retrieval for the application.

By isolating data-related operations, developers can optimize data access and storage mechanisms independently of the rest of the application.

Benefits of 3-Tier Architecture:

Scalability:
The modular nature of 3-tier architecture allows for independent scaling of each layer.

This enables efficient resource allocation, ensuring that specific components can be scaled based on demand without affecting the entire application.

2. Maintainability:

With clear separation of concerns, developers can make changes to one layer without impacting others.

This facilitates easier debugging, updates, and maintenance, as modifications can be confined to the relevant layer.

3. Flexibility and Adaptability:

The architecture accommodates technology changes and updates without disrupting the entire system.

New technologies can be integrated into specific layers, allowing the application to evolve over time.

Prerequisites:
kubectl — A command line tool for working with Kubernetes clusters. For more information, see Installing or updating kubectl. https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

eksctl — A command line tool for working with EKS clusters that automates many individual tasks. For more information, see Installing or updating. https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

AWS CLI — A command line tool for working with AWS services, including Amazon EKS. For more information, see Installing, updating, and uninstalling the AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html in the AWS Command Line Interface User Guide.

After installing the AWS CLI, I recommend that you also configure it. For more information, see Quick configuration with aws configure in the AWS Command Line Interface User Guide. https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config

Steps:
Step-1: Create an EKS Cluster
