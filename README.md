# TaskSphere

TaskSphere is a productivity management app that helps users manage their tasks and todos, and help
them keep track of
their productivity rate.

## Design

The design is
located [here](https://www.figma.com/file/sY1EuiCJTbcP6PsnNNizm1/TaskSphere?type=design&node-id=0%3A1&t=XVdUHzMx91fp8pzj-1)
.

## Contribution Guide

See [CONTRIBUTION_GUIDE.md](CONTRIBUTION_GUIDE.md)

### Contact Me

- Twitter: [@popestrings](https://twitter.com/popestrings)
- Linkedin: [fola-oluwafemi](https://linkedin.com/in/fola-oluwafemi)
- Email: [folaoluwafemi55@gmail.com](mailto:folaoluwafemi55@gmail.com)
- Phone: [+234 816 958 3715](tel:+2348169583715)
- Whatsapp: [@dart_god](https://wa.me/2348169583715)


## Have a glimpse of the app 😉
<div>
    <p>
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/1c1ef098-7d91-471d-8767-0edd517283b5" alt="Splash screen">
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/0d9e2583-5470-4c14-b5ce-484d803b4af1" alt="Onboarding screen">
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/a13cbaa7-c5d5-42b1-ba49-93f6c880305f" alt="Sign up screen">
    </p>
</div>

<div>
    <p>
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/c53736d9-1ebf-4675-9e71-bde0b088cac9" alt="Home Screen">
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/1ec73810-3f44-40a5-82a4-bb7ec0ad1635" alt="Search screen with a search in progress">
      <img width=33% src="https://github.com/folaoluwafemi/task_sphere/assets/89414401/3b3194ca-e8bc-48b7-b7d7-00d6e5288833" alt="About design and development screen">
    </p>
</div>

# Features

## Authentication

* Login
    - users must login to access the application
    - User login state should be persisted across app access: Users should only have to login once
      after which they
      should be automatically logged in once they open the app.
    - they’ll have to login again if:
        * they logged out
        * they app data got cleared
        * sign up


* Sign up
    - Users must have an account to access the app.
    - The required data are just their email, password and name.
    - their email must be verified

## Task Management (core feature)

In this product, the smallest unit of productivity is a Todo, which represents a it’s meaning.
a Task is a group of Todos.
This feature entails the various ways users can manage their productivity, my manipulating those two
entities in the
following ways:

* Edit
    * Edit a todo’s content, priority and status
    * Edit a task’s title, description, todos
* Search
    * Search through all their tasks by name/description and date created
    * Search through all todos by title and priority

### Entities:

* Todo
    * Status
    * Priority
    * Content
* Task
    * Title
    * Description
    * Todos

## Analytics

### Productivity History

- Users can view their productivity history like github’s contribution chart
- Users' tasks and todo update and completion rate is collected and displayed in a chart
