describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it "# 유저가 키워드 검색하면 기록에 남긴다." do
    @user.query('차언니')
    expect(@user.keywords.exists?(keyword: '차언니')).to match true
  end

end
