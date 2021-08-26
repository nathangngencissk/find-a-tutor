/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const getAllCourseCategories = /* GraphQL */ `
  query GetAllCourseCategories {
    getAllCourseCategories
  }
`;
export const getMainCourseCategories = /* GraphQL */ `
  query GetMainCourseCategories {
    getMainCourseCategories
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
  query GetCourse($id: Int) {
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
  query GetPath($id: Int) {
    getPath(id: $id)
  }
`;
export const getAllPaths = /* GraphQL */ `
  query GetAllPaths {
    getAllPaths
  }
`;
export const getPathRate = /* GraphQL */ `
  query GetPathRate($user_id: String, $path_id: Int) {
    getPathRate(user_id: $user_id, path_id: $path_id)
  }
`;
export const getPathCourses = /* GraphQL */ `
  query GetPathCourses($path_id: Int) {
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
export const getForumPosts = /* GraphQL */ `
  query GetForumPosts {
    getForumPosts
  }
`;
export const getPost = /* GraphQL */ `
  query GetPost($id: Int, $user_id: String) {
    getPost(id: $id, user_id: $user_id)
  }
`;
export const likeComment = /* GraphQL */ `
  query LikeComment($user_id: String, $post_comment_id: Int, $value: Boolean) {
    likeComment(
      user_id: $user_id
      post_comment_id: $post_comment_id
      value: $value
    )
  }
`;
export const upsertComment = /* GraphQL */ `
  query UpsertComment(
    $parent_comment_id: Int
    $post_id: Int
    $content: String
    $user_id: String
    $id: Int
  ) {
    upsertComment(
      parent_comment_id: $parent_comment_id
      post_id: $post_id
      content: $content
      user_id: $user_id
      id: $id
    )
  }
`;
export const myNotes = /* GraphQL */ `
  query MyNotes($user_id: String) {
    myNotes(user_id: $user_id)
  }
`;
export const upsertNote = /* GraphQL */ `
  query UpsertNote(
    $user_id: String
    $course_id: Int
    $title: String
    $content: String
    $fixed: Boolean
    $id: Int
    $created_at: String
    $updated_at: String
  ) {
    upsertNote(
      user_id: $user_id
      course_id: $course_id
      title: $title
      content: $content
      fixed: $fixed
      id: $id
      created_at: $created_at
      updated_at: $updated_at
    )
  }
`;
export const deleteNote = /* GraphQL */ `
  query DeleteNote($id: Int) {
    deleteNote(id: $id)
  }
`;
export const createNote = /* GraphQL */ `
  query CreateNote(
    $user_id: String
    $course_id: Int
    $title: String
    $content: String
    $fixed: Boolean
    $id: Int
    $created_at: String
    $updated_at: String
  ) {
    createNote(
      user_id: $user_id
      course_id: $course_id
      title: $title
      content: $content
      fixed: $fixed
      id: $id
      created_at: $created_at
      updated_at: $updated_at
    )
  }
`;
export const getCourseSteps = /* GraphQL */ `
  query GetCourseSteps($id: Int) {
    getCourseSteps(id: $id)
  }
`;
export const getCourseNotes = /* GraphQL */ `
  query GetCourseNotes($course_id: Int, $user_id: String) {
    getCourseNotes(course_id: $course_id, user_id: $user_id)
  }
`;
export const getCourseClasses = /* GraphQL */ `
  query GetCourseClasses($course_id: Int, $user_id: String) {
    getCourseClasses(course_id: $course_id, user_id: $user_id)
  }
`;
export const getCourseRate = /* GraphQL */ `
  query GetCourseRate($course_id: Int, $user_id: String) {
    getCourseRate(course_id: $course_id, user_id: $user_id)
  }
`;
export const getCourseReviews = /* GraphQL */ `
  query GetCourseReviews($id: Int) {
    getCourseReviews(id: $id)
  }
`;
export const rateCourse = /* GraphQL */ `
  query RateCourse(
    $course_id: Int
    $user_id: String
    $rating: Float
    $content: String
  ) {
    rateCourse(
      course_id: $course_id
      user_id: $user_id
      rating: $rating
      content: $content
    )
  }
`;
export const getCourseClassPosts = /* GraphQL */ `
  query GetCourseClassPosts($course_class_id: Int) {
    getCourseClassPosts(course_class_id: $course_class_id)
  }
`;
export const getUserCourses = /* GraphQL */ `
  query GetUserCourses($user_id: String) {
    getUserCourses(user_id: $user_id)
  }
`;
export const getCourseClass = /* GraphQL */ `
  query GetCourseClass($id: Int) {
    getCourseClass(id: $id)
  }
`;
export const enrollCourseClass = /* GraphQL */ `
  query EnrollCourseClass(
    $course_class_id: Int
    $user_id: String
    $created_at: String
    $updated_at: String
  ) {
    enrollCourseClass(
      course_class_id: $course_class_id
      user_id: $user_id
      created_at: $created_at
      updated_at: $updated_at
    )
  }
`;
