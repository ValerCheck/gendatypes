
# gendatypes

<!-- badges: start -->
[![codecov](https://codecov.io/gh/ValerCheck/gendatypes/branch/main/graph/badge.svg?token=GEW5L5N3AE)](https://codecov.io/gh/ValerCheck/gendatypes)
[![R-CMD-check](https://github.com/ValerCheck/gendatypes/workflows/R-CMD-check/badge.svg)](https://github.com/ValerCheck/gendatypes/actions)
<!-- badges: end -->

The goal of gendatypes is to provide generic data structures and utilities for restricting usage of lists to only one specific generic class. Among the utilities: extend list of classes only if the list doen't contain provided class name or introduce S3 %??% which by default works similar to null coalescing operator in C#, however it can be overriden.

## Installation

Currently the package is not deployed to CRAN. For installation use `install_github` command from `devtools` package.
```r
devtools::install_github("valercheck/gendatypes")
```

To install specific version use `ref` option and provide branch or tag name. Release tags use 4 numbers in version with `v` prefix.
```r
devtools::install_github("valercheck/gendatypes", ref = "v0.0.0.2")
```

## Functions

Current version contains next functions:

|Function name|Parameters|Description|
|:---:|---|---|
|**with_class**|**obj**: input object<br><br> **className**: class name to apply|Extend object with provided class name. Will apply class only if object doesn't alreay contain provided class|
|**validate_classes**|**object**: object to validate<br><br>**...**: dots used as replacement for **classes** parameter. Will be used if **classes** won't be provided.<br><br>**classes**: collection of classes which object must have|If provided object contains required classes, nothing will happen and function will be silently executed. Otherwise, execution will stop with error message.|
|**c_extended**|**...**: items to be used for vector creation <br><br> **as.names**: make names of the vector to be equal to values. <br><br> **as.list**: generate list object instead of vector. **as.names** in this case will change names in vector to keys in a list.|This is just extension for vector creation to reduce code for making names of vector equal to values. Useful when there are string values, which should be available by the same keys in this vector.|
|**%??%**|**lhs**: left operand <br><br> **rhs**: right operand|Inspired by C# null-coaelsing operator `??` which allows working with null values. In case if left hand side object is NaN, NULL, NA, or empty vector then right hand side object will be used. Otherwise left hand side object will be used.|
|**throw_exception**|**arg**: argument which will be mentioned in error<br><br> **message**: additional message to show before stopping execution.|Inspired by `ArgumentException` in C#|
|**as.typed_list**|**x**: object to convert to typed list. Typically it should be a list of items <br><br> **type_class**: class which all items in provided collection must have|When you have `list(object1, object2, object3)` and you want to make your list at least partially strongly typed by checking whether all items in the list have the same class definition|
|**is_typed_list**|**x**: input object|Check whether provided object is typed list|
|**typed_list.typeof**|**x**: input object|Returns generic item type in typed list|
|**typed_list.is**|**x**: input object <br> **type_class**: type class to verify|Returns either `TRUE` or `FALSE` based on comparison of generic item type with provided **type_class**|
|**validate_typed_list_class**|**x**: input object|Same as **is_typed_list** except it will stop execution with error if outcome of **is_typed_list** is `FALSE`|
|**`$.typed_list`**|**x**: input object <br> **name**: property name|S3 method for `$` function for `typed_list`. Returns a collection of properties by property name from each typed_list item|
|**`%$%`**|**lhs**: input object. Must have class `typed_list`. <br> **rhs**: property name on which perform expansion|Operator which works like **`$.typed_list`** except the result from this operator will give also typed list but not a vector of items or matrix|





