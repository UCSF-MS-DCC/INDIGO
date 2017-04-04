require 'test_helper'

class ConsensusFastqsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consensus_fastq = consensus_fastqs(:one)
  end

  test "should get index" do
    get consensus_fastqs_url
    assert_response :success
  end

  test "should get new" do
    get new_consensus_fastq_url
    assert_response :success
  end

  test "should create consensus_fastq" do
    assert_difference('ConsensusFastq.count') do
      post consensus_fastqs_url, params: { consensus_fastq: { INDIGO_ID: @consensus_fastq.INDIGO_ID, fastq: @consensus_fastq.fastq, gene: @consensus_fastq.gene } }
    end

    assert_redirected_to consensus_fastq_url(ConsensusFastq.last)
  end

  test "should show consensus_fastq" do
    get consensus_fastq_url(@consensus_fastq)
    assert_response :success
  end

  test "should get edit" do
    get edit_consensus_fastq_url(@consensus_fastq)
    assert_response :success
  end

  test "should update consensus_fastq" do
    patch consensus_fastq_url(@consensus_fastq), params: { consensus_fastq: { INDIGO_ID: @consensus_fastq.INDIGO_ID, fastq: @consensus_fastq.fastq, gene: @consensus_fastq.gene } }
    assert_redirected_to consensus_fastq_url(@consensus_fastq)
  end

  test "should destroy consensus_fastq" do
    assert_difference('ConsensusFastq.count', -1) do
      delete consensus_fastq_url(@consensus_fastq)
    end

    assert_redirected_to consensus_fastqs_url
  end
end
