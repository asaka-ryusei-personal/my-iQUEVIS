import react from "react";
import { ProgressBar } from "react-bootstrap";
import styles from "./Indicator.module.css";

export type IndicatorProps = {
  percent: number;
};

export default function Indicator({ percent }: IndicatorProps) {
  return (
    <ProgressBar
      animated
      now={percent}
      label={`${percent}%`}
      className={styles.indicator}
    />
  );
}
