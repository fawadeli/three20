#import "Three20/TTErrorView.h"
#import "Three20/TTDefaultStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static CGFloat kVPadding1 = 30;
static CGFloat kVPadding2 = 20;
static CGFloat kHPadding = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TTErrorView

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image {
  if (self = [self init]) {
    self.title = title;
    self.subtitle = subtitle;
    self.image = image;
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageView];

    _titleView = [[UILabel alloc] init];
    _titleView.backgroundColor = [UIColor clearColor];
    _titleView.textColor = TTSTYLEVAR(tableErrorTextColor);
    _titleView.font = TTSTYLEVAR(errorTitleFont);
    _titleView.textAlignment = UITextAlignmentCenter;
    [self addSubview:_titleView];
    
    _subtitleView = [[UILabel alloc] init];
    _subtitleView.backgroundColor = [UIColor clearColor];
    _subtitleView.textColor = TTSTYLEVAR(tableErrorTextColor);
    _subtitleView.font = TTSTYLEVAR(errorSubtitleFont);
    _subtitleView.textAlignment = UITextAlignmentCenter;
    _subtitleView.numberOfLines = 0;
    [self addSubview:_subtitleView];
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_imageView);
  TT_RELEASE_SAFELY(_titleView);
  TT_RELEASE_SAFELY(_subtitleView);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
  _subtitleView.size = [_subtitleView sizeThatFits:CGSizeMake(self.width - kHPadding*2, 0)];
  [_titleView sizeToFit];
  [_imageView sizeToFit];

  CGFloat maxHeight = _imageView.height + _titleView.height + _subtitleView.height
                      + kVPadding1 + kVPadding2;
  BOOL canShowImage = _imageView.image && self.height > maxHeight;
  
  CGFloat totalHeight = 0;

  if (canShowImage) {
    totalHeight += _imageView.height;
  }
  if (_titleView.text.length) {
    totalHeight += (totalHeight ? kVPadding1 : 0) + _titleView.height;
  }
  if (_subtitleView.text.length) {
    totalHeight += (totalHeight ? kVPadding2 : 0) + _subtitleView.height;
  }
  
  CGFloat top = floor(self.height/2 - totalHeight/2);
  
  if (canShowImage) {
    _imageView.origin = CGPointMake(floor(self.width/2 - _imageView.width/2), top);
    _imageView.hidden = NO;
    top += _imageView.height + kVPadding1;
  } else {
    _imageView.hidden = YES;
  }
  if (_titleView.text.length) {
    _titleView.origin = CGPointMake(floor(self.width/2 - _titleView.width/2), top);
    top += _titleView.height + kVPadding2;
  }
  if (_subtitleView.text.length) {
    _subtitleView.origin = CGPointMake(floor(self.width/2 - _subtitleView.width/2), top);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString*)title {
  return _titleView.text;
}

- (void)setTitle:(NSString*)title {
  _titleView.text = title;
}

- (NSString*)subtitle {
  return _subtitleView.text;
}

- (void)setSubtitle:(NSString*)subtitle {
  _subtitleView.text = subtitle;
}

- (UIImage*)image {
  return _imageView.image;
}

- (void)setImage:(UIImage*)image {
  _imageView.image = image;
}

@end
