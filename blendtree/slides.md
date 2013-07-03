# Animated Blend Tree

---
# Animated Blend Tree

## Summary

 * Concept
 * Nodes
 * Usage
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

BlendTree <- LeafAnimation

    !c++
    MyLeafAnimationNode = & BlendTree->GetRootNode();

    MyLeafAnimationNode->SetAnimation(
        ANIMATED_MANAGER_GetAnimation( animation_name )
        );

    MyLeafAnimationNode->SetItLoops( BOOL_True );

    MyLeafAnimationNode->Reset();

---
# Animated Blend Tree - Usage
## Basic usage


---
# Animated Blend Tree - Initializer

ANIMATED_BLEND_NODE_VISITOR_INITIALIZER

 * Data-driven
 * Based on naming convention
    * Requires a prefix, usually model name
    * Leaf animation: [prefix]_[node_name]_anim
    * Random switch:  [prefix]_[node_name]XX_anim

