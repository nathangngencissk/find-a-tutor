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
  query GetExerciseList($id: String, $user_id: String) {
    getExerciseList(id: $id, user_id: $user_id)
  }
`;
export const answerExercise = /* GraphQL */ `
  query AnswerExercise($user_id: String, $exercise_id: Int) {
    answerExercise(user_id: $user_id, exercise_id: $exercise_id)
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
export const commentPost = /* GraphQL */ `
  query CommentPost($user_id: String, $post_id: Int, $content: String) {
    commentPost(user_id: $user_id, post_id: $post_id, content: $content)
  }
`;
export const createForumPost = /* GraphQL */ `
  query CreateForumPost(
    $title: String
    $description: String
    $category_id: Int
    $creator_id: String
  ) {
    createForumPost(
      title: $title
      description: $description
      category_id: $category_id
      creator_id: $creator_id
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
export const getMyBankAccounts = /* GraphQL */ `
  query GetMyBankAccounts($user_id: String) {
    getMyBankAccounts(user_id: $user_id)
  }
`;
export const createBankAccount = /* GraphQL */ `
  query CreateBankAccount(
    $bank_code: String
    $bank_name: String
    $account_type: String
    $agencia: String
    $conta: String
    $favorite: Boolean
    $user_id: String
    $created_at: String
    $updated_at: String
  ) {
    createBankAccount(
      bank_code: $bank_code
      bank_name: $bank_name
      account_type: $account_type
      agencia: $agencia
      conta: $conta
      favorite: $favorite
      user_id: $user_id
      created_at: $created_at
      updated_at: $updated_at
    )
  }
`;
export const updateBankAccount = /* GraphQL */ `
  query UpdateBankAccount(
    $id: String
    $bank_code: String
    $bank_name: String
    $account_type: String
    $agencia: String
    $conta: String
    $favorite: Boolean
    $user_id: String
    $created_at: String
    $updated_at: String
  ) {
    updateBankAccount(
      id: $id
      bank_code: $bank_code
      bank_name: $bank_name
      account_type: $account_type
      agencia: $agencia
      conta: $conta
      favorite: $favorite
      user_id: $user_id
      created_at: $created_at
      updated_at: $updated_at
    )
  }
`;
export const deleteBankAccount = /* GraphQL */ `
  query DeleteBankAccount($id: String) {
    deleteBankAccount(id: $id)
  }
`;
export const favoriteBankAccount = /* GraphQL */ `
  query FavoriteBankAccount($id: Int, $user_id: String) {
    favoriteBankAccount(id: $id, user_id: $user_id)
  }
`;
export const getCourses = /* GraphQL */ `
  query GetCourses($user_id: String) {
    getCourses(user_id: $user_id)
  }
`;
export const createCourseSteps = /* GraphQL */ `
  query CreateCourseSteps($steps: String) {
    createCourseSteps(steps: $steps)
  }
`;
export const updateCourseSteps = /* GraphQL */ `
  query UpdateCourseSteps($steps: String) {
    updateCourseSteps(steps: $steps)
  }
`;
export const deleteCourseSteps = /* GraphQL */ `
  query DeleteCourseSteps($steps: String) {
    deleteCourseSteps(steps: $steps)
  }
`;
export const deleteCourseStep = /* GraphQL */ `
  query DeleteCourseStep($step_id: String) {
    deleteCourseStep(step_id: $step_id)
  }
`;
export const createCourse = /* GraphQL */ `
  query CreateCourse(
    $name: String
    $description: String
    $short_description: String
    $image: String
    $price: Float
    $category_id: Int
    $owner_id: String
  ) {
    createCourse(
      name: $name
      description: $description
      short_description: $short_description
      image: $image
      price: $price
      category_id: $category_id
      owner_id: $owner_id
    )
  }
`;
export const updateCourse = /* GraphQL */ `
  query UpdateCourse(
    $id: Int
    $name: String
    $description: String
    $short_description: String
    $image: String
    $price: Float
    $category_id: Int
    $owner_id: String
    $created_at: String
  ) {
    updateCourse(
      id: $id
      name: $name
      description: $description
      short_description: $short_description
      image: $image
      price: $price
      category_id: $category_id
      owner_id: $owner_id
      created_at: $created_at
    )
  }
`;
export const deleteCourse = /* GraphQL */ `
  query DeleteCourse($course_id: Int) {
    deleteCourse(course_id: $course_id)
  }
`;
export const getTutorCourseClasses = /* GraphQL */ `
  query GetTutorCourseClasses($user_id: String) {
    getTutorCourseClasses(user_id: $user_id)
  }
`;
export const deleteCourseClass = /* GraphQL */ `
  query DeleteCourseClass($id: Int) {
    deleteCourseClass(id: $id)
  }
`;
export const createCourseClassPosts = /* GraphQL */ `
  query CreateCourseClassPosts($posts: String) {
    createCourseClassPosts(posts: $posts)
  }
`;
export const updateCourseClassPosts = /* GraphQL */ `
  query UpdateCourseClassPosts($posts: String) {
    updateCourseClassPosts(posts: $posts)
  }
`;
export const deleteCourseClassPosts = /* GraphQL */ `
  query DeleteCourseClassPosts($posts: String) {
    deleteCourseClassPosts(posts: $posts)
  }
`;
export const deleteCourseClassPost = /* GraphQL */ `
  query DeleteCourseClassPost($id: String) {
    deleteCourseClassPost(id: $id)
  }
`;
export const createCourseClass = /* GraphQL */ `
  query CreateCourseClass(
    $name: String
    $description: String
    $image: String
    $start_date: String
    $end_date: String
    $schedule: String
    $how_to_access: String
    $course_id: Int
    $duration: Int
  ) {
    createCourseClass(
      name: $name
      description: $description
      image: $image
      start_date: $start_date
      end_date: $end_date
      schedule: $schedule
      how_to_access: $how_to_access
      course_id: $course_id
      duration: $duration
    )
  }
`;
export const updateCourseClass = /* GraphQL */ `
  query UpdateCourseClass(
    $id: Int
    $name: String
    $description: String
    $image: String
    $start_date: String
    $end_date: String
    $schedule: String
    $how_to_access: String
    $course_id: Int
    $duration: Int
    $created_at: String
  ) {
    updateCourseClass(
      id: $id
      name: $name
      description: $description
      image: $image
      start_date: $start_date
      end_date: $end_date
      schedule: $schedule
      how_to_access: $how_to_access
      course_id: $course_id
      duration: $duration
      created_at: $created_at
    )
  }
`;
export const getTutorExerciseLists = /* GraphQL */ `
  query GetTutorExerciseLists($user_id: String) {
    getTutorExerciseLists(user_id: $user_id)
  }
`;
export const deleteExerciseList = /* GraphQL */ `
  query DeleteExerciseList($id: Int) {
    deleteExerciseList(id: $id)
  }
`;
export const createExercises = /* GraphQL */ `
  query CreateExercises($exercises: String) {
    createExercises(exercises: $exercises)
  }
`;
export const updateExercises = /* GraphQL */ `
  query UpdateExercises($exercises: String) {
    updateExercises(exercises: $exercises)
  }
`;
export const deleteExercise = /* GraphQL */ `
  query DeleteExercise($id: Int) {
    deleteExercise(id: $id)
  }
`;
export const createExerciseList = /* GraphQL */ `
  query CreateExerciseList(
    $creator_id: String
    $title: String
    $tags: String
    $status: String
    $description: String
  ) {
    createExerciseList(
      creator_id: $creator_id
      title: $title
      tags: $tags
      status: $status
      description: $description
    )
  }
`;
export const updateExerciseList = /* GraphQL */ `
  query UpdateExerciseList(
    $id: Int
    $creator_id: String
    $title: String
    $tags: String
    $status: String
    $description: String
    $created_at: String
  ) {
    updateExerciseList(
      id: $id
      creator_id: $creator_id
      title: $title
      tags: $tags
      status: $status
      description: $description
      created_at: $created_at
    )
  }
`;
export const getTutorPaths = /* GraphQL */ `
  query GetTutorPaths($user_id: String) {
    getTutorPaths(user_id: $user_id)
  }
`;
export const deletePath = /* GraphQL */ `
  query DeletePath($id: Int) {
    deletePath(id: $id)
  }
`;
export const createPathCourses = /* GraphQL */ `
  query CreatePathCourses($courses: String) {
    createPathCourses(courses: $courses)
  }
`;
export const updatePathCourses = /* GraphQL */ `
  query UpdatePathCourses($courses: String) {
    updatePathCourses(courses: $courses)
  }
`;
export const deletePathCourses = /* GraphQL */ `
  query DeletePathCourses($courses: String) {
    deletePathCourses(courses: $courses)
  }
`;
export const createPath = /* GraphQL */ `
  query CreatePath(
    $name: String
    $description: String
    $image: String
    $creator_id: String
  ) {
    createPath(
      name: $name
      description: $description
      image: $image
      creator_id: $creator_id
    )
  }
`;
export const updatePath = /* GraphQL */ `
  query UpdatePath(
    $id: Int
    $name: String
    $description: String
    $image: String
    $creator_id: String
    $created_at: String
  ) {
    updatePath(
      id: $id
      name: $name
      description: $description
      image: $image
      creator_id: $creator_id
      created_at: $created_at
    )
  }
`;
export const createPayment = /* GraphQL */ `
  query CreatePayment($value: String, $user_id: String, $courses: [Int]) {
    createPayment(value: $value, user_id: $user_id, courses: $courses)
  }
`;
export const confirmPayment = /* GraphQL */ `
  query ConfirmPayment($id: Int, $order_id: String, $user_id: String) {
    confirmPayment(id: $id, order_id: $order_id, user_id: $user_id)
  }
`;
export const createPayout = /* GraphQL */ `
  query CreatePayout($value: String, $user_id: String) {
    createPayout(value: $value, user_id: $user_id)
  }
`;
export const sendPayout = /* GraphQL */ `
  query SendPayout(
    $id: Int
    $value: String
    $user_id: String
    $created_at: String
  ) {
    sendPayout(
      id: $id
      value: $value
      user_id: $user_id
      created_at: $created_at
    )
  }
`;
export const getMyPayouts = /* GraphQL */ `
  query GetMyPayouts($user_id: String) {
    getMyPayouts(user_id: $user_id)
  }
`;
export const getMyBalance = /* GraphQL */ `
  query GetMyBalance($user_id: String) {
    getMyBalance(user_id: $user_id)
  }
`;
export const getDashboardData = /* GraphQL */ `
  query GetDashboardData($user_id: String) {
    getDashboardData(user_id: $user_id)
  }
`;
export const getAdminData = /* GraphQL */ `
  query GetAdminData {
    getAdminData
  }
`;
export const getPayoutsForApproval = /* GraphQL */ `
  query GetPayoutsForApproval {
    getPayoutsForApproval
  }
`;
export const changePayoutStatus = /* GraphQL */ `
  query ChangePayoutStatus($id: String, $status: String, $updated_at: String) {
    changePayoutStatus(id: $id, status: $status, updated_at: $updated_at)
  }
`;
export const getCoursesForApproval = /* GraphQL */ `
  query GetCoursesForApproval {
    getCoursesForApproval
  }
`;
export const changeCourseStatus = /* GraphQL */ `
  query ChangeCourseStatus($id: String, $status: String, $updated_at: String) {
    changeCourseStatus(id: $id, status: $status, updated_at: $updated_at)
  }
`;
export const getExercisesForApproval = /* GraphQL */ `
  query GetExercisesForApproval {
    getExercisesForApproval
  }
`;
export const changeExerciseStatus = /* GraphQL */ `
  query ChangeExerciseStatus(
    $id: String
    $status: String
    $updated_at: String
  ) {
    changeExerciseStatus(id: $id, status: $status, updated_at: $updated_at)
  }
`;
export const getPayments = /* GraphQL */ `
  query GetPayments {
    getPayments
  }
`;
