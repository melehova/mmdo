
# MATLAB Optimization Methods Collection

This repository showcases high-quality MATLAB implementations of optimization algorithms, designed with developers in mind. The codebase emphasizes clarity, modularity, and extensibility, making it ideal for research, teaching, and rapid prototyping. Each method is implemented with best practices, thorough documentation, and reusable components.


## Developer-Focused Features

- **Comprehensive Algorithm Library:**
  - Includes classic and modern optimization techniques, each with clean, well-commented code.
- **Modular & Extensible Design:**
  - Algorithms and utilities are separated for easy maintenance and extension. Add your own methods or utilities with minimal effort.
- **Consistent API:**
  - Unified function signatures and input/output formats for seamless integration and experimentation.
- **Robust Testing:**
  - Example scripts and test files ensure correctness and provide usage patterns for each method.
- **Documentation & Readability:**
  - Every function is documented with clear descriptions, parameter explanations, and usage notes.
- **Performance & Reliability:**
  - Efficient implementations with attention to numerical stability and edge cases.
- **MATLAB Best Practices:**
  - Follows MATLAB coding standards for readability, maintainability, and compatibility.

## Getting Started

1. **Clone the repository:**
   ```pwsh
   git clone https://github.com/melehova/mmdo.git
   ```
2. **Open in MATLAB:**
   - Add the repository folder to your MATLAB path.
3. **Run Example Scripts:**
   - Use provided scripts (e.g., `metHookeJeevesTest.m`) to see algorithms in action.


## Usage Example


```matlab
% Example: Run Golden Section method with developer-friendly API
addpath('methods');
f = @(x) (x-2).^2;
[xmin, fmin] = metGoldenSection(f, 0, 5);
fprintf('Minimum at x = %.4f, f(x) = %.4f\n', xmin, fmin);
```


## Algorithms Included

- Golden Section
- Dichotomy
- Newton's Method
- Hooke-Jeeves
- Steepest Descent
- Svenn's Method
- Step Adaptation
- Polak-Ribiere-Fletcher-Reeves
- ...and more, all implemented with attention to code quality and extensibility.

## License

This project is licensed under the MIT License.



## Author, Code Quality & Project Background


Developed by [Veronika Melekhova](https://github.com/melehova) as a course work for the subject "Mathematical Methods of Operations Research" during my bachelor's studies in Computer Science.

**Project Topic:**
"Unconstrained Minimization Methods for Multivariate Functions Using Various Techniques"

This repository reflects a commitment to professional standards, maintainability, and developer experience. If you appreciate well-structured MATLAB code, you'll find this project a valuable resource for both learning and development.
