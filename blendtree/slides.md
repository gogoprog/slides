# Animated Blend Tree

---
# Animated Blend Tree

## Summary

 * Concept
 * Nodes
 * Usage
 * Loader
 * Initializer
 * Demo
 * Extra

---
# Animated Blend Tree - Concept
---
# Animated Blend Tree - Concept
## Before
 * Update = Sample

## Now
 * Asks his root node to update/blend
 * Nodes can have children nodes
 * Updated each frame : advances cursors
 * Blend called only in GetSkeletonPose on model.
 * GetSkeletonPose is called only when evaluating shader constant -> when visible.

---
# Animated Blend Tree - Nodes
---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_LEAF_ANIMATION

 * Has a ANIMATED_ANIMATION
 * Update will advance its cursor
 * Blend will sample its animation
 * So no children

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_SWITCH

 * Has children
 * Can cross fade between children
 * Cross-fade is manual

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_SWITCH

 * Has children
 * Can cross fade between children
 * Cross fade is random
 * Cross-fade is automatic (when looping)
 * Weight per child

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_MIXER

 * Has children
 * Blend will mix its children
 * Weight per child

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_SEQUENCE

 * Has children
 * Can cross fade between children
 * Cross-fade is automatic (children order)

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_LOCOMOTION

 * Has no children
 * Has a list of animation/speed

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_DEFORMER

 * Has one child
 * Has a list of scale per bone

---
# Animated Blend Tree - Usage
---
# Animated Blend Tree - Usage
## Quick usage

<style type="text/css">
.nodes div { font-size:15px; border:1px solid black; display:inline-block; padding:3px;}
</style>

<div class="nodes"/>
<div>BlendTree</div> --- <div>LeafAnimation</div>
</div>

    !c++
    MyLeafAnimationNode = & BlendTree->GetRootNode();

    MyLeafAnimationNode->SetAnimation(
        ANIMATED_MANAGER_GetAnimation( animation_name )
        );

    MyLeafAnimationNode->SetItLoops( BOOL_True );

    MyLeafAnimationNode->Reset();

 * Sampled only if visible
 * Animation/loop must be set each time
 * No blending transitions between animations

---
# Animated Blend Tree - Usage
## Basic usage

<div class="nodes"/>
<div>BlendTree</div> --- <div>Switch</div> ---\ <br/>
<div style="margin-left:180px;">LeafAnimation "walk"</div><br/>
<div style="margin-left:180px;">LeafAnimation "idle"</div><br/>
<div style="margin-left:180px;">LeafAnimation "eat"</div><br/>
<div style="margin-left:180px;">LeafAnimation "hit"</div><br/>
</div>

    !c++
    MySwitchNode = & BlendTree->GetRootNode();

    MySwitchNode->GetNodeAtName("walk").SetAnimation(...);
    // ...

    MySwitchNode->CrossFadeTo( "idle", 0.1f );
    MySwitchNode->CrossFadeTo( "walk", 0.1f );

 * Animations/loop must be set only once
 * Blending transitions

---
# Animated Blend Tree - Loader

---
# Animated Blend Tree - Loader

    !json
    {
        "name":"main",
        "type":"switch",
        "children": [
            {
                "name":"eat",
                "type":"animation"
            },
            {
                "name":"idle",
                "type":"random",
                "loop": true
            },
            {
                "name":"hit",
                "type":"animation"
            },
            {
                "name":"walk",
                "type":"locomotion"
            }
        ]
    }

Input file in json<br/>
No animation file specified<br/>
Only blend tree structure<br/>

---
# Animated Blend Tree - Initializer
---
# Animated Blend Tree - Initializer

ANIMATED_BLEND_NODE_VISITOR_INITIALIZER

 * Data-driven
 * Based on naming convention
    * Requires a prefix, usually model name
    * Leaf animation: [prefix]_[node_name]_anim
    * Random switch:  [prefix]_[node_name]XX_anim (only if empty!)

Example:<br/>
Prefix: "nornos"<br/>
nornos_eat_anim.resource<br/>
nornos_idle01_anim.resource<br/>
nornos_idle02_anim.resource<br/>
nornos_idle03_anim.resource

---
# Animated Blend Tree - Demo
---
# Animated Blend Tree - Extra
---
# Animated Blend Tree - Extra

## What's next?

 * More nodes
 * Edition in javascript
 * ...

---
# The End

<center>
For Fishing Cactus,<br/>
by Gauthier Billot <br/>
< gauthier.billot @ fishingcactus.com >
</center>