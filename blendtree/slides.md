# Animated Blend Tree

---
# Animated Blend Tree

## Summary

 * Concept
 * Nodes
 * Usage
 * Loader
 * Initializer
 * Viewer
 * Extra

---
# Animated Blend Tree - Concept

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_SWITCH

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_LEAF_ANIMATION

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_SWITCH

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_MIXER

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_SEQUENCE

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_LOCOMOTION

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_DEFORMER

---
# Animated Blend Tree - Nodes
## ANIMATED_BLEND_RANDOM_LOOK_AT

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

ANIMATED_BLEND_TREE_LOADER

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
                "type":"animation",
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

---
# Animated Blend Tree - Initializer

ANIMATED_BLEND_NODE_VISITOR_INITIALIZER

 * Data-driven
 * Based on naming convention
    * Requires a prefix, usually model name
    * Leaf animation: [prefix]_[node_name]_anim
    * Random switch:  [prefix]_[node_name]XX_anim