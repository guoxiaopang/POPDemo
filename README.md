#FaceBook POP
##1.简介
POP是一个动画引擎，用于扩展iOS、OSX的动画类型。
CADisplayLink是一个和屏幕刷新率(每秒60帧)相同的定时器，pop实现的动画就是基于该定时器，它的每一帧根据指定的time function计算出动画的中间值，然后将计算好的值赋给视图或图层(可以是任意对象)的属性(比如透明度、frame等)。
POP动画结束后，不会回到起始位置。

官网地址 : [https://github.com/facebook/pop](https://github.com/facebook/pop)

文档地址 : [https://github.com/tiantianlan/POPDemo](https://github.com/tiantianlan/POPDemo)

主要包含以下类型动画：
>POPBasicAnimation 基础动画
>
>POPSpringAnimation 弹簧动画
>
>POPDecayAnimation 衰减动画
>
>POPCustomAnimation 自定义动画

我们先看一个例子：

![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/Cell.gif)

##2. 基础用法

###2.1 方法创建
>1. 创建POPAnimation对象 `POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];`
>
>2. 设置需要变化的kPOP值 `basicAnimation.property = [POPAnimatableProperty propertyWithName:aName]`
>
>3. 设置变化的最终属性toValue `basicAnimation.toValue = [NSValue xxxxx]`
>
>4. 添加动画到视图 `[self.roundView pop_addAnimation:basicAnimation forKey:nil];`
>

###2.2 代理方法 POPAnimationDelegate 

```
- (void)pop_animationDidStart:(POPAnimation *)anim
{
    NSLog(@"动画开始时候调用");
}

- (void)pop_animationDidReachToValue:(POPAnimation *)anim
{
    NSLog(@"将要达到toValue值是调用");
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    NSLog(@"动画完成时调用");
}

- (void)pop_animationDidApply:(POPAnimation *)anim
{
    NSLog(@"动画执行过程中一直调用"); 
}

```

###2.3 block

通过completionBlock 设置 与上面代理方法调用时间相同

```
typedef void (^POPAnimationDidStartBlock)(POPAnimation *anim);

typedef void (^POPAnimationDidReachToValueBlock)(POPAnimation *anim);

typedef void (^POPAnimationCompletionBlock)(POPAnimation *anim, BOOL finished);

typedef void (^POPAnimationDidApplyBlock)(POPAnimation *anim);

```

block用法例子：

```
basic.completionBlock = ^(POPAnimation *anim, BOOL finished) { //完成状态block
    if (finished)
    {
        [self changePOP]; //调用自己 继续重复动画
    }
};    
```

##3. POPBasicAnimation
POPBasicAnimation 常用于移动 缩放 颜色 透明度等等

例1：我们对view的中心位置进行移动

``` 
POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];  //初始化对中心点进行移动
basic.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //淡入淡出
basic.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centery)]; //动画终点值
basic.duration = 0.4; //持续时间
[self.roundView pop_addAnimation:basic forKey:@"centerMove"]; //添加动画到View
```
动画效果：

![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/basicMove.gif)

例2:对View大小进行动画

```
POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
if (_scale)
{
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
}
else
{
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
}
_scale = !_scale;
basic.completionBlock = ^(POPAnimation *anim, BOOL finished) { //完成状态block
    if (finished)
    {
        [self changePOP]; //调用自己 继续重复动画
    }
};
[self.roundView pop_addAnimation:basic forKey:@"basic"];
```

动画效果:

![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/scale.gif)

##4. POPSpringAnimation
POPSpringAnimation 对属性进行动画，具有回弹效果。
弹簧动画可以设置一些物理特效，比如：
> 1. springBounciness 弹簧弹力,弹力越大振幅越大 [0 - 20]默认14
> 2. springSpeed 速度,速度越大，动画结束越快 [0 - 20]
> 3. dynamicsTension 弹簧的拉力
> 4. dynamicsMass 物体的质量
> 5. dynamicsFriction 摩擦力
> 6. velocity 速率

例1：根据物理特性控制View的Center

```
POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
spring.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
spring.springBounciness = _springBouncinessValue; // 弹簧弹力 [0,20] 默认4, 越大震动幅度越大
spring.springSpeed = _speedValue ? _speedValue : 12; // [0 - 20] 越大 动画结束越快
spring.dynamicsTension = _dynamicsTensionValue ? _dynamicsTensionValue : 214; //弹簧的拉力
spring.dynamicsMass = _dynamicsMassValue ? _dynamicsMassValue : 1.0f; // 质量
spring.delegate =self;
    
[self.rectAngleView pop_addAnimation:spring forKey:@"center"];
spring.completionBlock = ^(POPAnimation *anim, BOOL finished){
    if (finished)
    {
        NSLog(@"finish");
    }
};

```

动画效果:
![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/springBasic.gif)

例2：绘制一个弹性的圆

```
POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
strokeAnimation.toValue = @(strokeEnd);
strokeAnimation.springBounciness = 12.f;
strokeAnimation.removedOnCompletion = NO;
[self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];

```
 
动画效果:
![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/circle.gif)


##5.POPDecayAnimation
衰减动画主要是设置一个衰减值`velocity`来控制
例子：对位置移动进行衰减

```
POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
anim.velocity = [NSValue valueWithCGPoint:CGPointMake(velocity.x, velocity.y)];
anim.deceleration = 0.998;   
[self.roundView.layer pop_addAnimation:anim forKey:@"AnimationPosition"];
```
动画效果：
![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/decay.gif)



##6.POPCustomAnimation
POP默认三种动画都继承自`POPPropertyAnimation`， POPPropertyAnimation中定义了一个叫`property`的属性。
POPPropertyAnimation主要包含三种方法：

```
prop.readBlock = ^(id obj, CGFloat values[]) {
        // 告诉POP当前的属性值，可以不用设置
        // values[0] = 0.0f; // 如果自定义的属性只有一个，只用设置value[0] 
        // 有多个 需要设置多个值，比如CGPoint 需要设置 values[0],values[1]
    };
    
prop.writeBlock = ^(id obj, const CGFloat values[]) {
    	// 修改变化后的值  如果给label添加的动画，obj就表示这个label
    };
prop.threshold = 0.01;  // 值越大block调用的次数越少，默认不设置
```

 
例1：改变label Text属性

    POPBasicAnimation *basic = [POPBasicAnimation animation]; 
    basic.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat values[]){ //告诉POP当前的属性值
            values[0] = 0.0f; 
        };
        
        prop.writeBlock = ^(id obj, const CGFloat values[]){ //修改变化后的属性值
            [obj setText:[NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100]]; // 从value中获取数据 赋值给Label
        };
        prop.threshold = 0.1;
      }]; // 定义pop如何操作Label上的值 然后复制给动画
    basic.property = prop;
    basic.fromValue = @(0);
    basic.toValue = @(3 * 60);
    basic.duration = 3 *60;
    basic.beginTime = CACurrentMediaTime() + 1.0f; // 延迟1秒开始
    [self.countLabel pop_addAnimation:basic forKey:@"count"];



动画效果：
![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/time.gif)



##7.动画组合

可以将多种效果组合在一起够成动画。
只需要将动画创建好，依次增加到view上即可。

例1：push视图 弹簧动画改变Y值 + 基础动画改变透明度 + 基础动画旋转

```
POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
anim.springBounciness = 6; //弹簧
anim.springSpeed = 10;
anim.fromValue = @-200;
anim.toValue = @(self.view.center.y);
    
POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
// 透明度
opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
opacityAnim.duration = 0.25;
opacityAnim.toValue = @1.0;
    
POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    // 旋转
rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
rotationAnim.beginTime = CACurrentMediaTime() + 0.1;
rotationAnim.duration = 0.3;
rotationAnim.toValue = @(0);
    
[self.pushView.layer pop_addAnimation:anim forKey:@"AnimationScale"];
[self.pushView.layer pop_addAnimation:opacityAnim forKey:@"AnimateOpacity"];
[self.pushView.layer pop_addAnimation:rotationAnim forKey:@"AnimateRotation"];
```
动画效果：

![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/push.gif)

alert:

![Alt Text](https://github.com/tiantianlan/Image/blob/master/POP/alert.gif)

进度条:

https://github.com/tiantianlan/Image/blob/master/POP/progress.gif

##8.总结
学习iOS动画最好先学习POP动画，比较简单易懂，而且用法都是一样的。

其实只需要熟练掌握POP自带的三种动画 即可完成大部分的动画效果。

 如果实在是无法满足你的需求的话 自定义动画也基本可以满足你的要求。
