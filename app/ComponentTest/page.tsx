"use client";

import React, { useState } from "react";
import styles from "./ComponentTest.module.css";
import DescriptionInputForm from "@/components/DescriptionInputForm/DescriptionInputForm";
import SingleSelectionInputForm from "@/components/SingleSelectionInputForm/SingleSelectionInputForm";
import BreadcrumbsList from "@/components/BreadcrumbsList/BreadcrumbsList";
import Indicator from "@/components/Indicator/Indicator";
import ToggleButton from "@/components/ToggleButton/ToggleButton";

const DescriptionInputFormProps1 = {
  questionId: 1,
  questionTitle: "濱西くんの声量は、どのようにすれば改革できるとおもいますか。",
  isRequired: true,
};

const DescriptionInputFormProps2 = {
  questionId: 2,
  questionTitle: "新しいあいさつを考えてください。",
  isRequired: false,
  description: "例）おはようございます。",
};

const SingleSelectionInputFormProps = {
  questionId: 3,
  questionTitle: "あなたの好きな色は何ですか？",
  isRequired: true,
  options: ["赤", "青", "緑", "黄色"],
};

const IndicatorProps = {
  percent: 75,
};

export default function Page() {
  const [toggleChecked, setToggleChecked] = useState(false);

  return (
    <>
      <p>これは作成したコンポーネントのテストを行うページです。</p>
      <DescriptionInputForm
        key={DescriptionInputFormProps1.questionId}
        questionId={DescriptionInputFormProps1.questionId}
        questionTitle={DescriptionInputFormProps1.questionTitle}
        isRequired={DescriptionInputFormProps1.isRequired}
      />
      <DescriptionInputForm
        key={DescriptionInputFormProps2.questionId}
        questionId={DescriptionInputFormProps2.questionId}
        questionTitle={DescriptionInputFormProps2.questionTitle}
        isRequired={DescriptionInputFormProps2.isRequired}
        description={DescriptionInputFormProps2.description}
      />
      <SingleSelectionInputForm
        key={SingleSelectionInputFormProps.questionId}
        questionId={SingleSelectionInputFormProps.questionId}
        questionTitle={SingleSelectionInputFormProps.questionTitle}
        isRequired={SingleSelectionInputFormProps.isRequired}
        options={SingleSelectionInputFormProps.options}
      />
      <BreadcrumbsList
        crumbs={[
          { label: "Home", href: "/" },
          { label: "Components", href: "/components" },
          { label: "Current Component", active: true },
        ]}
      />
      <Indicator percent={IndicatorProps.percent} />
      <ToggleButton
        label="Toggle me"
        checked={toggleChecked}
        onChange={setToggleChecked}
      />
    </>
  );
}
