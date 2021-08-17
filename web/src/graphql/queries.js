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
  query GetCourse($id: String, $user_id: String) {
    getCourse(id: $id, user_id: $user_id)
  }
`;
export const searchCourse = /* GraphQL */ `
  query SearchCourse(
    $keywords: [String]
    $category_id: String
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
