/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const getAllCourseCategories = /* GraphQL */ `
  query GetAllCourseCategories {
    getAllCourseCategories
  }
`;
export const getPopularCourses = /* GraphQL */ `
  query GetPopularCourses {
    getPopularCourses
  }
`;
export const getStudyingNow = /* GraphQL */ `
  query GetStudyingNow {
    getStudyingNow
  }
`;
export const getCourse = /* GraphQL */ `
  query GetCourse($id: String) {
    getCourse(id: $id)
  }
`;
export const searchCourse = /* GraphQL */ `
  query SearchCourse(
    $keywords: [String]
    $category_id: Int
    $order_by: String
    $min_eval: Float
    $max_eval: Float
    $min_price: Float
    $max_price: Float
  ) {
    searchCourse(
      keywords: $keywords
      category_id: $category_id
      order_by: $order_by
      min_eval: $min_eval
      max_eval: $max_eval
      min_price: $min_price
      max_price: $max_price
    )
  }
`;
export const myCourses = /* GraphQL */ `
  query MyCourses($id: String) {
    myCourses(id: $id)
  }
`;
export const myCourseClasses = /* GraphQL */ `
  query MyCourseClasses($id: String) {
    myCourseClasses(id: $id)
  }
`;
export const searchPath = /* GraphQL */ `
  query SearchPath(
    $keywords: [String]
    $order_by: String
    $min_eval: Float
    $max_eval: Float
  ) {
    searchPath(
      keywords: $keywords
      order_by: $order_by
      min_eval: $min_eval
      max_eval: $max_eval
    )
  }
`;
export const getMySavedPaths = /* GraphQL */ `
  query GetMySavedPaths($id: String) {
    getMySavedPaths(id: $id)
  }
`;
export const savePath = /* GraphQL */ `
  query SavePath($user_id: String, $path_id: Int) {
    savePath(user_id: $user_id, path_id: $path_id)
  }
`;
export const unsavePath = /* GraphQL */ `
  query UnsavePath($user_id: String, $path_id: Int) {
    unsavePath(user_id: $user_id, path_id: $path_id)
  }
`;
export const ratePath = /* GraphQL */ `
  query RatePath($user_id: String, $path_id: Int, $rating: Float) {
    ratePath(user_id: $user_id, path_id: $path_id, rating: $rating)
  }
`;
export const getPath = /* GraphQL */ `
  query GetPath($id: String) {
    getPath(id: $id)
  }
`;
export const getPathRate = /* GraphQL */ `
  query GetPathRate($user_id: String, $path_id: String) {
    getPathRate(user_id: $user_id, path_id: $path_id)
  }
`;
export const getPathCourses = /* GraphQL */ `
  query GetPathCourses($path_id: String) {
    getPathCourses(path_id: $path_id)
  }
`;
export const getExerciseLists = /* GraphQL */ `
  query GetExerciseLists($user_id: String) {
    getExerciseLists(user_id: $user_id)
  }
`;
export const getExerciseList = /* GraphQL */ `
  query GetExerciseList($id: String) {
    getExerciseList(id: $id)
  }
`;
