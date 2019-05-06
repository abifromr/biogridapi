context("test-requests")

test_that("interactions works", {
    res <- interactions(accessKey = Sys.getenv('accessKey'),
                        geneList = c('MDM2', 'MDM3'))
    expect_true(is.data.frame(res))
    expect_equal(nrow(res), 5)
  })

test_that('identifiers works', {
  res <- identifiers(accessKey = Sys.getenv('accessKey'))
  expect_true(is.data.frame(res))
  expect_true(nrow(res) > 0)
})

test_that('organism works', {
  res <- organisms(accessKey = Sys.getenv('accessKey'))
  expect_true(is.data.frame(res))
  expect_true(nrow(res) > 0)
})

test_that('organism works', {
  res <- evidence(accessKey = Sys.getenv('accessKey'))
  expect_true(is.data.frame(res))
  expect_true(nrow(res) > 0)
})
