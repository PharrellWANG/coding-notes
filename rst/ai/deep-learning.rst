Deep Learning
=============

Confusion Matrix
----------------
By definition a confusion matrix :math:`C` is such that :math:`C_{ij}` is equal to 
the number of observations known to be in group :math:`i` and predicted to be in group :math:`j`.

References 
~~~~~~~~~~
1. `sklearn.metrics.confusion_matrix <https://scikit-learn.org/stable/modules/generated/sklearn.metrics.confusion_matrix.html>`_

Object Detection
----------------
13 Dec 2020

Evaluation Metrics
~~~~~~~~~~~~~~~~~~

**mAP** : mean average precision.

To evaluate object detection models like R-CNN and YOLO, the mean average precision (mAP) is used. 
The mAP compares the ground-truth bounding box to the detected box and returns a score. 
The higher the score, the more accurate the model is in its detections.


References
~~~~~~~~~~

1. `Evaluating object detection models using mean average precision (mAP) <https://blog.paperspace.com/mean-average-precision/>`_

Classification
--------------

How to evaluate a binary classification problem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Accuracy, Precision, Recall and F1-score
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

One possible measure to evaluate binary classification models is **Accuracy** :eq:`classification_accuracy`, i.e.,
*the fraction of predictions we got right*:

.. math::
    :label: classification_accuracy

    Accuracy = \frac{TP+TN}{TP+TN+FP+FN}


.. the below method is used to force line breaks. usage is ``|br|``,
    src: https://salishsea-meopar-docs.readthedocs.io/en/latest/work_env/sphinx_docs.html#forcing-line-breaks

.. |br| raw:: html

    <br>

in which |br|
:math:`TP`: True Position, which is an outcome where *the model correctly predicts the positive class*. |br|
:math:`TN`: True Negative, which is an outcome where *the model correctly predicts the negative class*. |br|
:math:`FP`: False Position, which is an outcome where *the model incorrectly predicts the positive class*. |br|
:math:`FN`: False Negative, which is an outcome where *the model incorrectly predicts the negative class*. |br|

However, in many cases, accuracy is a poor or misleading metric:

* Most often when different kinds of mistakes have different costs;
* Typical case includes class imbalance, when positives or negatives are extremely rare.

For class-imbalanced problems, it is useful to separate out different kinds of errors,
such as **Precision**:eq:`classification_precision` and **Recall**:eq:`classification_recall`:

.. math::
    :label: classification_precision

    Precision = \frac{TP}{TP+FP}


.. math::
    :label: classification_recall

    Recall = \frac{TP}{TP+FN}

Precision answers the question of **what proportion of positive identifications was actually correct**. |br|
Recall answers the question of **what proportion of actual positives was identified correctly**.

.. tip::
    The higher the precision, the more confident the model is when it classifies a sample as Positive. 

    The higher the recall, the more positive samples the model correctly classified as Positive.

    When a model has high recall but low precision, then the model classifies most of the positive samples correctly but it has many false positives (i.e. classifies many Negative samples as Positive). When a model has high precision but low recall, then the model is accurate when it classifies a sample as Positive but it may classify only some of the positive samples.

If model A has better precision and better recall than model B, then model A is probably better.

**F1 score** (also **F-score** or **F-measure**) :eq:`f1-measure` is the `harmonic average <https://en.wikipedia.org/wiki/Harmonic_mean>`_ [#]_ of precision and recall.

.. math::
    :label: f1-measure

    F_1=\Bigg(\frac{precision^{-1}+recall^{-1}}{2} \Bigg)^{-1}=\frac{2 \cdot precision \cdot recall}{precision+recall}

The importance of the F1 score is different based on the scenario. Lets assume the target variable is a binary label.

#. Balanced class: In this situation, the F1 score can effectively be ignored, the mis-classification rate is key.
#. Unbalanced class, but both classes are important: If the class distribution is highly skewed (such as 80:20 or 90:10), then a classifier can get a low mis-classification rate simply by choosing the majority class. In such a situation, I would choose the classifier that gets high F1 scores on both classes, as well as low mis-classification rate. A classifier that gets low F1-scores should be overlooked.
#. Unbalanced class, but one class if more important that the other. E.g., in Fraud detection, it is more important to correctly label an instance as fraudulent, as opposed to labeling the non-fraudulent one. In this case, I would pick the classifier that has a good F1 score only on the important class. Recall that the F1-score is available per class.


ROC Curve and AUC
^^^^^^^^^^^^^^^^^
An `ROC curve <https://developers.google.com/machine-learning/crash-course/classification/roc-and-auc>`_ (receiver operating characteristic curve) is
a graph showing the performance of a classification model at all classification thresholds [#]_.

.. note:: The ROC is also known as a relative operating characteristic curve [#]_ , because it is a comparison of two operating characteristics (TPR and FPR) as the criterion changes.

This curve plots two parameters:

* True Positive Rate, a.k.a sensitivity, recall, hit rate.
* False Positive Rate, a.k.a fall-out.


AUC stands for "Area under the ROC Curve". That is, AUC measures the entire two-dimensional area underneath the entire ROC curve (think integral calculus) from (0,0) to (1,1).

AUC provides an aggregate measure of performance across all possible classification thresholds. One way of interpreting AUC is as the probability that the model ranks a random positive example more highly than a random negative example.

For more info, see references.

.. note:: The origin of the ROC terminology:

            Peterson, W., Birdsall, T., Fox, W. (1954). The theory of signal detectability, Transactions of the IRE Professional Group on Information Theory, 4, 4, pp. 171 - 212.

            Abstract: An optimum observer required to give a yes or no answer simply chooses an operating level and concludes that the receiver input arose from signal plus noise only when this level is exceeded by the output of his likelihood ratio receiver. Associated with each such operating level are conditional probabilities that the answer is a false alarm and the conditional probability of detection. Graphs of these quantities called receiver operating characteristic, or ROC, curves are convenient for evaluating a receiver. If the detection problem is changed by varying, for example, the signal power, then a family of ROC curves is generated. Such things as betting curves can easily be obtained from such a family.


.. [#] The `harmonic average <https://en.wikipedia.org/wiki/Harmonic_mean>`_ can be expressed as the reciprocal of the arithmetic mean of the reciprocals of the given set of observations.
.. [#] https://developers.google.com/machine-learning/crash-course/classification/roc-and-auc
.. [#] https://en.wikipedia.org/wiki/Receiver_operating_characteristic