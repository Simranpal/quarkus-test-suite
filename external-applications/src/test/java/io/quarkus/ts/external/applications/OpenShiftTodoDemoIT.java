package io.quarkus.ts.external.applications;

import org.junit.jupiter.api.Disabled;

import io.quarkus.test.scenarios.OpenShiftScenario;
import io.quarkus.test.scenarios.annotations.DisabledOnNative;
import io.quarkus.test.scenarios.annotations.DisabledOnQuarkusSnapshot;

// TODO: enable when Quarkus TODO application migrates to Quarkus 3
@Disabled("Disabled until TODO application migrates to Quarkus 3")
@DisabledOnQuarkusSnapshot(reason = "999-SNAPSHOT is not available in the Maven repositories in OpenShift")
@DisabledOnNative(reason = "Native + s2i not supported")
@OpenShiftScenario
public class OpenShiftTodoDemoIT extends TodoDemoIT {
}
